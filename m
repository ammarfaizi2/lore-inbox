Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318292AbSHKMjJ>; Sun, 11 Aug 2002 08:39:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318293AbSHKMjJ>; Sun, 11 Aug 2002 08:39:09 -0400
Received: from u212-239-148-48.freedom.planetinternet.be ([212.239.148.48]:44292
	"EHLO jebril.pi.be") by vger.kernel.org with ESMTP
	id <S318292AbSHKMjI>; Sun, 11 Aug 2002 08:39:08 -0400
Message-Id: <200208111241.g7BCfakl018731@jebril.pi.be>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
Subject: 2.5.31: modules don't work at all
Date: Sun, 11 Aug 2002 14:41:36 +0200
From: "Michel Eyckmans (MCE)" <mce@pi.be>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


After upgrading from 2.5.30 to 2.5.31, nothing related to modules 
works for me. Insmod, rmmod, you name it. They all cause errors
along the line of: "QM_SYMBOLS: Bad Address". Any suggestions?

This is with the very latest modutils (2.4.19). These work fine 
with 2.5.30.

MCE
