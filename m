Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWDQUlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWDQUlW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 16:41:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbWDQUlW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 16:41:22 -0400
Received: from pproxy.gmail.com ([64.233.166.177]:30537 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750877AbWDQUlW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 16:41:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Qvirj87jYrCQ+ThBsPu2R/Ksd0//KA5D/mVhPLQ5W850wdHlojE9sS3nsBhHap/XWis7XYT2lvRn1DZKA2A9ICNCi+ic4ITpbd+7aitUT7Tc4DRYUeQhHlNuYZIeVLVtp/uv30BN+QTWOeQto129xMZG+ePW7QDPkyt6tMoYCBE=
Message-ID: <4d8e3fd30604171341q46e7e1efxa81146bf04388a75@mail.gmail.com>
Date: Mon, 17 Apr 2006 22:41:18 +0200
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: [announce] gkernel 0.1d released, a graphical tool to remove installed kernels (and all the files installed by make install and make install_modules)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
if you are used to compile and install your own kernels you could find
this utility useful, it removes using a graphical interface the
selected kernel and all the files installed with "make install"
(vmlinuz, config, system.map e dir /lib/modules).
The script requires zenity and bash.

Information, screenshots and download:
http://paolo.ciarrocchi.googlepages.com/gkernel

Comments are more than appreciate!

Ciao,

--
Paolo
http://paolociarrocchi.googlepages.com
