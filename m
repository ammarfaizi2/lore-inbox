Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263991AbSKIBRc>; Fri, 8 Nov 2002 20:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263960AbSKIBRc>; Fri, 8 Nov 2002 20:17:32 -0500
Received: from pfaff.Stanford.EDU ([128.12.189.154]:28800 "EHLO
	pfaff.Stanford.EDU") by vger.kernel.org with ESMTP
	id <S263991AbSKIBRb>; Fri, 8 Nov 2002 20:17:31 -0500
To: James Simmons <jsimmons@phoenix.infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.45 / fb vga16fb build error
References: <Pine.LNX.4.44.0211090118570.14371-100000@phoenix.infradead.org>
Reply-To: blp@cs.stanford.edu
From: Ben Pfaff <blp@cs.stanford.edu>
Date: 08 Nov 2002 17:24:10 -0800
In-Reply-To: <Pine.LNX.4.44.0211090118570.14371-100000@phoenix.infradead.org>
Message-ID: <87adkjcz7p.fsf@pfaff.Stanford.EDU>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons <jsimmons@phoenix.infradead.org> writes:

> > > I finished porting over the driver to the new api last night. It will be 
> > > part of the next pull by Linus. I have a few more things I need done over 
> > > the weekend for the new fbdev stuff.
> > 
> > Was there something wrong with my patches to do the same thing
> > that have been in Alan Cox's tree for some time now?
> 
> No, but the final api is done and struct display_switch is going away!!!
> So I had to fix the driver to work with the latest changes.

I see.  I didn't realize that the API was changing again.  Oh
well.
-- 
"Now I have to go wash my mind out with soap."
--Derick Siddoway
