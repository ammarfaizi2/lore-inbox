Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263355AbTGASmj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 14:42:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263365AbTGASmj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 14:42:39 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:12947
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263355AbTGASmd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 14:42:33 -0400
Subject: Re: [Fwd: Bug in Kernel 2.4.20-8]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Cornelius =?ISO-8859-1?Q?K=F6lbel?= <cornelius.koelbel@gmx.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F0139D5.1080602@gmx.de>
References: <3F0139D5.1080602@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Organization: 
Message-Id: <1057085646.18955.19.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 01 Jul 2003 19:54:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-07-01 at 08:35, Cornelius Kölbel wrote:
> I am using Kernel 2.4.20. I admit, it is the kernel of RedHat 9.
> I hope this is not, because RedHat did so much changes to the Kernel

Always hard to tell. It is worth filing Red Hat kernel bugs in
https://bugzilla.redhat.com/bugzilla and picking up current errata
kernels if there are newer ones

> I was just typing a mail, when the caps lock light and the scroll lock light went on.
> Nothing happend anymore. No mouse, no keyboard.
> I resetted the computer.

This is a panic - the machine got itself into a state that could not
continue. The flashing lights are giving data in morse (useful for those
truely desperate debugging situations only 8))


