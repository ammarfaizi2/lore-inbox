Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261879AbVDOReP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261879AbVDOReP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 13:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261880AbVDOReP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 13:34:15 -0400
Received: from atlanta_nt2.atlanta.glenayre.com ([157.230.176.123]:38155 "EHLO
	mail.atlanta.glenayre.com") by vger.kernel.org with ESMTP
	id S261879AbVDOReN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 13:34:13 -0400
Message-ID: <1113586421.26941.121.camel@scox.glenatl.glenayre.com>
From: "Malita, Florin" <Florin.Malita@Glenayre.com>
To: linux-os@analogic.com
Cc: Allison <fireflyblue@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel Rootkits
Date: Fri, 15 Apr 2005 13:33:41 -0400
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-04-15 at 13:16 -0400, Richard B. Johnson wrote:
> I'm not sure there really are any "kernel" rootkits. You need to be 
> root to install a module and you need to be root to replace a kernel 
> with a new (possibly altered) one. If you are root, you don't 
> need an exploit.

rootkit != exploit

The exploit is used to gain root privileges while the rootkit is used
after that to install & hide backdoors, sniffers, keyloggers etc.

http://en.wikipedia.org/wiki/Rootkit

