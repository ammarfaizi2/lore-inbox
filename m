Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266278AbTAIMjt>; Thu, 9 Jan 2003 07:39:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266286AbTAIMjt>; Thu, 9 Jan 2003 07:39:49 -0500
Received: from [212.4.54.130] ([212.4.54.130]:38154 "EHLO
	station3.kontor.itsopen.no") by vger.kernel.org with ESMTP
	id <S266278AbTAIMjs>; Thu, 9 Jan 2003 07:39:48 -0500
Subject: Are linux network drivers really affected by this?
From: Nils Petter Vaskinn <nils.petter.vaskinn@itsopen.net>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 09 Jan 2003 13:52:03 +0100
Message-Id: <1042116723.2556.3.camel@station3>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


http://www.kb.cert.org/vuls/id/412115


Summary: Some network drivers don't pad ethernet packets with nulls,
they are filled with "garbage" often from previously sent packets. Linux
is mentioned as vulnerable.



Nils Petter Vaskinn
