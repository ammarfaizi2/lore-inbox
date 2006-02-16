Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932137AbWBPVgy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932137AbWBPVgy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 16:36:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbWBPVgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 16:36:54 -0500
Received: from mail11.bluewin.ch ([195.186.18.61]:28290 "EHLO
	mail11.bluewin.ch") by vger.kernel.org with ESMTP id S932137AbWBPVgy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 16:36:54 -0500
Date: Thu, 16 Feb 2006 16:32:33 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: Scott_Kilau@digi.com, wendyx@us.ltcfwd.linux.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/serial/Kconfig: remove reference to non-existing Documentation/jsm.txt
Message-ID: <20060216213233.GA2304@krypton>
References: <20060211163238.GB30922@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060211163238.GB30922@stusta.de>
User-Agent: Mutt/1.5.11+cvs20060126
From: apgo@patchbomb.org (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 11, 2006 at 05:32:38PM +0100, Adrian Bunk wrote:
> There's no reason pointing users to non-existing documentation.
 
Similar patch is in Russell's linux-2.6-serial; Re: kernel bugzilla
#5176 (http://bugzilla.kernel.org/show_bug.cgi?id=5176)

> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> --- linux-2.6.16-rc2-mm1-full/drivers/serial/Kconfig.old	2006-02-11 17:29:34.000000000 +0100
> +++ linux-2.6.16-rc2-mm1-full/drivers/serial/Kconfig	2006-02-11 17:29:50.000000000 +0100
> @@ -902,8 +902,6 @@
>  	  something like this to connect more than two modems to your Linux
>  	  box, for instance in order to become a dial-in server. This driver
>  	  supports PCI boards only.
> -	  If you have a card like this, say Y here and read the file
> -	  <file:Documentation/jsm.txt>.
>  
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called jsm.
> 
