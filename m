Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292980AbSCIXQO>; Sat, 9 Mar 2002 18:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292982AbSCIXQE>; Sat, 9 Mar 2002 18:16:04 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:33689 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S292980AbSCIXPw>; Sat, 9 Mar 2002 18:15:52 -0500
Message-ID: <XFMail.020310001311.pirx@minet.uni-jena.de>
X-Mailer: XFMail 1.4.0 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <3C8A8AF6.3080002@web.de>
Date: Sun, 10 Mar 2002 00:13:11 +0100 (CET)
Reply-To: pirx@minet.uni-jena.de
From: 520042182928-0001@t-online.de (Martin Huenniger)
To: Stephan Wienczny <wienczny@web.de>
Subject: RE: PROBLEM: Video Module doesn't compile
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Just set the value to 

info->node = NODEV;

and everything will (hopefully) work fine


Martin

-----------------------------------------------
E-Mail: Martin Huenniger <pirx@minet.uni-jena.de>
Date: 10-Mar-02
Time: 00:13:11
-----------------------------------------------
