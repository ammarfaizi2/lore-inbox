Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262540AbTJ3O1X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 09:27:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262546AbTJ3O1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 09:27:23 -0500
Received: from mail01.mail.esat.net ([193.120.142.6]:10638 "EHLO
	mail01.mail.esat.net") by vger.kernel.org with ESMTP
	id S262540AbTJ3O1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 09:27:22 -0500
Message-ID: <0a5201c39ef1$ede54b40$6e69690a@RIMAS>
From: "Remus" <rmocius@auste.elnet.lt>
To: <linux-kernel@vger.kernel.org>
Subject: Strange problem with kernel 2.6.0-test8/9 on Compaq PIII 500 PC
Date: Thu, 30 Oct 2003 14:26:50 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

I got very strange problem with kernel 2.6.0-test8/9.

I have compiled the kernel with CPU 486/586 support and etc.
It works fine with P4, 486, AMD x586 CPUs but if I try to use on my
Compaq PIII 500Mhz PCs it hangs on after decompresing kernel.
Screen becames black and nothing hapens anymore.

These PCs works fine with kernel 2.4.xx kernels with very simmilar
configuration.

Any ideas?

Remus



