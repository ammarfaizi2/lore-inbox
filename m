Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317383AbSFRKuD>; Tue, 18 Jun 2002 06:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317384AbSFRKuC>; Tue, 18 Jun 2002 06:50:02 -0400
Received: from ti131310a080-0035.bb.online.no ([80.212.16.35]:31496 "HELO
	grimm1.grimstad") by vger.kernel.org with SMTP id <S317383AbSFRKuB>;
	Tue, 18 Jun 2002 06:50:01 -0400
Date: Tue, 18 Jun 2002 12:41:51 +0200
From: "Nils O. =?ISO-8859-1?Q?Sel=E5sdal" ?= <noselasd@Utel.no>
Message-Id: <200206181041.g5IAfpL20399@localhost.localdomain>
To: linux-kernel@vger.kernel.org
Subject: ReiserFS & NFS oops
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just wanted to know if this is a known problem and if it might be fixed in
the near future:
Using 2.4.19-pre8 just one filesystem with reiserfs, I exported a directory. Mounted
it on another hosts and started writing a large (500mb) file to it, that resulted
in the server filesystem going full and the server locked up hard.

-
NOS@Utel.no
