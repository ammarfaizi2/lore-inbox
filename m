Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270712AbTG0JpK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 05:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270711AbTG0JpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 05:45:09 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:37900 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S270709AbTG0JpF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 05:45:05 -0400
Date: Sun, 27 Jul 2003 12:00:17 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Voicu Liviu <pacman@mscc.huji.ac.il>
Cc: linux-kernel@vger.kernel.org
Subject: Re: make menuconfig
Message-ID: <20030727100017.GB21246@mars.ravnborg.org>
Mail-Followup-To: Voicu Liviu <pacman@mscc.huji.ac.il>,
	linux-kernel@vger.kernel.org
References: <3F2391EF.8080707@mscc.huji.ac.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F2391EF.8080707@mscc.huji.ac.il>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 27, 2003 at 11:48:47AM +0300, Voicu Liviu wrote:
> Hi dear list,
> I have heard that "make menuconfig" for kernel 2.6-beta1 is deprecated? 
> Am I correct? If yes then how do I get into the config?
You are wrong - make menuconfig is still OK.
Mak sure to read the document made by dave j. before playing too much
with 2.6.
It is at: www.codemonkey.org.uk - but I cannot get in contact with it
right now.
See instead:
http://lwn.net/Articles/39901/

> Alos tryied to run 'make menuconfig' from tcsh and got error like: 
> Missing }.
Works for me. Could you provide exact error-message etc.

	Sam
