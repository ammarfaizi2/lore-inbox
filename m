Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbWEDGk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWEDGk5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 02:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751413AbWEDGk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 02:40:57 -0400
Received: from mail-a01.ithnet.com ([217.64.83.96]:40893 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S1751409AbWEDGk4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 02:40:56 -0400
X-Sender-Authentication: net64
Date: Thu, 4 May 2006 08:40:54 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Greg KH <greg@kroah.com>
Cc: stable@kernel.org, ja@ssi.bg, gregkh@suse.de, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [stable] Re: Linux 2.6.16.13 / Problem
Message-Id: <20060504084054.fbb0167e.skraw@ithnet.com>
In-Reply-To: <20060503213408.GA14090@kroah.com>
References: <20060502222827.GA29287@kroah.com>
	<20060503154532.a0963c65.skraw@ithnet.com>
	<20060503185409.GB10466@kroah.com>
	<20060503230906.82e0c9f2.skraw@ithnet.com>
	<20060503213408.GA14090@kroah.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 May 2006 14:34:08 -0700
Greg KH <greg@kroah.com> wrote:

> On Wed, May 03, 2006 at 11:09:06PM +0200, Stephan von Krawczynski wrote:
> > On Wed, 3 May 2006 11:54:09 -0700
> > Greg KH <greg@kroah.com> wrote:
> > 
> > > On Wed, May 03, 2006 at 03:45:32PM +0200, Stephan von Krawczynski wrote:
> > > > Hi Greg,
> > > > 
> > > > unfortunately I see some problem regarding 2.6.16.13:
> > > 
> > > Makes sense, as nothing in .13 was for something like this :)
> > 
> > Sorry, didn't get that joke (no native englishman), you may explain in private
> > to me having spare time. Do you mean this is a _new_ story completely
> > unrelated to .13? 
> 
> No, meaning that .13 fixed a totally different problem from what you are
> reporting, so it is expected that the same problem you see with .12 is
> also in .13.

The problem is: I do not see it with .12 (or .11, or .10 (all tested)), but
only with .13. So maybe the .13-patch isn't as unrelated as it looks on first
sight...
(I used merely all 2.6.16.X, downloaded them always as complete archives)
-- 
Regards,
Stephan

