Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289338AbSAOBYp>; Mon, 14 Jan 2002 20:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289341AbSAOBYf>; Mon, 14 Jan 2002 20:24:35 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:13067 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S289338AbSAOBYX>; Mon, 14 Jan 2002 20:24:23 -0500
Date: Tue, 15 Jan 2002 01:26:34 +0000
From: John Levon <movement@marcelothewonderpenguin.com>
To: linux-kernel@vger.kernel.org
Cc: mylinuxk@yahoo.ca
Subject: Re: Link kernel module with a library
Message-ID: <20020115012634.GB58740@compsoc.man.ac.uk>
In-Reply-To: <20020114230207.35391.qmail@web14911.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020114230207.35391.qmail@web14911.mail.yahoo.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Bendik Singers - Afrotid
X-Toppers: N/A
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 06:02:07PM -0500, Michael Zhu wrote:

> Hello,everyone, can I link a kernel module with a
> library? In my module I need to call the functions
> exported from the .a library. I couldn't link that
> library with my module. Can anyone give me a hand on
> this? Thanks in advance.

(please use kernelnewbies mailing list next time, http://kernelnewbies.org/)

You can't use any user space code that relies on code not included in the kernel.
Give more detail on kernelnewbies of your problem, and we'll explain what you actually
need to do.

regards
john

-- 
"Now why did you have to go and mess up the child's head, so you can get another gold waterbed ?
 You fake-hair contact-wearing liposuction carnival exhibit, listen to my rhyme ..."
