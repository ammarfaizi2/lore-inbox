Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWCANGU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWCANGU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 08:06:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbWCANGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 08:06:20 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:60274 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932104AbWCANGT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 08:06:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Uv6akK3VJvSjexLfqWOOqkHcmyVemoPNr7OO8L2VHGHUGpbuMvyzYClUdAmz4BUsoagl1C2F1A1Utm6NcGRYOTNBEcvd/gwkVSIaR+UaQH2iII+hKn5334Xl5RG0P9HBaxVFu5EmdGJsFYDAQTRwSx027Fg7H1/5Vv6b0eCFEto=
Message-ID: <503e0f9d0603010506x416e21e3o679a0b713f870a8a@mail.gmail.com>
Date: Wed, 1 Mar 2006 18:36:18 +0530
From: "tim tim" <tictactoe.tim@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: depmod kernel compilation
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello.. i am trying to install 2.6.10 kernel.. and used the following..

make xconfig -- selected lodable module support
make bzImage
make modules
make modules_install

then it show some depmod.. how can i install the kernel.. here i have
a fully installed  RedHat EL3 os. 2.4.21...

how figure it out
