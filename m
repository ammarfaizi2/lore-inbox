Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbUKTV6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUKTV6L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 16:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263190AbUKTV6L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 16:58:11 -0500
Received: from fe02.axelero.hu ([195.228.240.90]:56841 "EHLO
	digpala.axelero.hu") by vger.kernel.org with ESMTP id S261718AbUKTV6I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 16:58:08 -0500
Message-ID: <000301c4cf4c$0d771a70$6402a8c0@SUTIHOME>
From: "Zoltan Sutto" <sutto.zoltan@rutinsoft.hu>
To: <linux-kernel@vger.kernel.org>
Subject: 2.4.28 module compile problem
Date: Sat, 20 Nov 2004 22:58:21 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-2";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I got this error message compiling modules for kernel 2.4.28.

dn_neigh.c:584: `THIS_MODULE' undeclared here (not in a function)
dn_neigh.c:584: initializer element is not constant
dn_neigh.c:584: (near initialization for `dn_neigh_seq_fops.owner')
make[2]: *** [dn_neigh.o] Error 1
make[2]: Leaving directory `/usr/src/linux-2.4.28/net/decnet'
make[1]: *** [_modsubdir_decnet] Error 2
make[1]: Leaving directory `/usr/src/linux-2.4.28/net'
make: *** [_mod_net] Error 2

Cookie
