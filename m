Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261232AbUC3VQJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 16:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261234AbUC3VQJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 16:16:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:15849 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261232AbUC3VQG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 16:16:06 -0500
X-Authenticated: #1892127
Mime-Version: 1.0 (Apple Message framework v613)
Content-Transfer-Encoding: 7bit
Message-Id: <321B041D-8298-11D8-AC61-0003931E0B62@gmx.li>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: Martin Schaffner <schaffner@gmx.li>
Subject: booting 2.6.4 from OpenFirmware
Date: Tue, 30 Mar 2004 23:18:39 +0100
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I try to boot linux-2.6.4 from OpenFirmware on my Apple iBook2 (dual 
USB). I'm using the image named "vmlinux.elf-pmac". While linux-2.4.25 
boots fine, linux-2.6.4 doesn't without the following modifications:

http://membres.lycos.fr/schaffner/howto/linux26-boot-of.txt

(I found this procedure by trial and error, by mixing stuff from 2.4 
into the build of 2.6.)

If I try to boot the stock kernel, OpenFirmware tells me "Claim 
failed", and returns to the command prompt.

Does anybody have an idea what is the cause of this?

Thanks,

Martin

