Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbTHaNQV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 09:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262036AbTHaNQV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 09:16:21 -0400
Received: from pasky.ji.cz ([213.226.226.138]:29173 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262035AbTHaNQQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 09:16:16 -0400
Date: Sun, 31 Aug 2003 15:16:16 +0200
From: Petr Baudis <pasky@ucw.cz>
To: vojtech@suse.cz, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [RESEND] Force mouse detection as imps/2 (and fix my KVM switch)
Message-ID: <20030831131616.GA5106@pasky.ji.cz>
Mail-Followup-To: vojtech@suse.cz, linux-kernel@vger.kernel.org,
	akpm@osdl.org
References: <20030831130619.GA1804@zion.rivenstone.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030831130619.GA1804@zion.rivenstone.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Sun, Aug 31, 2003 at 03:06:19PM CEST, I got a letter,
where jhf@rivenstone.net told me, that...
> diff -urN linux-2.6.0-test4/Documentation/kernel-parameters.txt linux-2.6.0-test4_changed/Documentation/kernel-parameters.txt
> --- linux-2.6.0-test4/Documentation/kernel-parameters.txt	2003-08-31 08:08:00.000000000 -0400
> +++ linux-2.6.0-test4_changed/Documentation/kernel-parameters.txt	2003-08-31 08:15:29.000000000 -0400
> @@ -785,6 +785,8 @@
>  
>  	psmouse_noext	[HW,MOUSE] Disable probing for PS2 mouse protocol extensions
>  
> +	psmouse_imps2	[HW,MOUSE] Probe only for Intellimouse PS2 mouse protocol extensions
> +
>  	pss=		[HW,OSS] Personal Sound System (ECHO ESC614)
>  			Format: <io>,<mss_io>,<mss_irq>,<mss_dma>,<mpu_io>,<mpu_irq>

Just a trivial remark - please try to keep this file in more-or-less
alphabetical order, thanks.

Kind regards,

-- 
 
				Petr "Pasky" Baudis
.
Perfection is reached, not when there is no longer anything to add, but when
there is no longer anything to take away.
	-- Antoine de Saint-Exupery
.
Stuff: http://pasky.ji.cz/
