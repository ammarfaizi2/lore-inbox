Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbVC0XRM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbVC0XRM (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 18:17:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261601AbVC0XRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 18:17:11 -0500
Received: from mail.kroah.org ([69.55.234.183]:2522 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261531AbVC0XRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 18:17:03 -0500
Date: Sun, 27 Mar 2005 15:09:56 -0800
From: Greg KH <greg@kroah.com>
To: Aaron Gyes <floam@sh.nu>
Cc: Adrian Bunk <bunk@stusta.de>,
       "Dr. David Alan Gilbert" <gilbertd@treblig.org>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Message-ID: <20050327230955.GA32749@kroah.com>
References: <1111886147.1495.3.camel@localhost> <490243b66dc7c3f592df7a7d0769dcb7@mac.com> <1111913399.6297.28.camel@laptopd505.fenrus.org> <16d78e9ea33380a1f1ad90c454fb6e1d@mac.com> <20050327180417.GD3815@gallifrey> <20050327183522.GM4285@stusta.de> <1111951014.9831.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1111951014.9831.4.camel@localhost>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 27, 2005 at 11:16:54AM -0800, Aaron Gyes wrote:
> > And then the user want to upgrade the 2.0 kernel that shipped with this 
> > box although the company that made the hardware went bankrupt some years 
> > ago.
> > 
> > If the user has the source of the driver, he can port the driver or hire 
> > someone to port the driver (this "obscure piece of hardware" might also 
> > be an expensive piece of hardware).
> 
> So what? Sure, GPL'd drivers are easier for an end-user in that case.
> What does that have to do with law? What about what's better for the
> company that made the device? Should NVIDIA be forced to give up their
> secrets to all their competitors because some over zealous developers
> say so? Should the end-users of the current drivers be forced to lose
> out on features such as sysfs and udev compatability?

It's not zealotry, it's called being compliant with the license of the
kernel.  It's as simple as that.  

If you ignore the license, you will suffer the consequences of it, just
like if you ignore the license of any closed source chunk of software.
Would you expect the owner of that software to turn a blind eye toward
violators?

greg k-h
