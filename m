Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315981AbSEQNNk>; Fri, 17 May 2002 09:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316155AbSEQNNj>; Fri, 17 May 2002 09:13:39 -0400
Received: from serenity.mcc.ac.uk ([130.88.200.93]:55562 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S315981AbSEQNNh>; Fri, 17 May 2002 09:13:37 -0400
Date: Fri, 17 May 2002 14:13:35 +0100
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Subject: Re: AUDIT: copy_from_user is a deathtrap.
Message-ID: <20020517131335.GA81462@compsoc.man.ac.uk>
In-Reply-To: <E178hJt-0006Rb-00@the-village.bc.nu> <E178hJU-0002GS-00@wagner.rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 17, 2002 at 10:58:08PM +1000, Rusty Russell wrote:

> Again, like we did 12 months ago you mean?

Adding some comments on the interface to uaccess.h might help. It's way
more convenient than looking it up in your guide

regards
john
-- 
"It is very difficult to prophesy, especially when it pertains to the
 future."
 	- Patrick Kurzawe
