Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286208AbRLJJv5>; Mon, 10 Dec 2001 04:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286205AbRLJJvr>; Mon, 10 Dec 2001 04:51:47 -0500
Received: from [195.66.192.167] ([195.66.192.167]:6930 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S286204AbRLJJvb>; Mon, 10 Dec 2001 04:51:31 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: Strange SAK event
Date: Mon, 10 Dec 2001 11:50:42 -0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01121011504200.01165@manta>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A few minutes ago I experienced strange thing: I tried to kill hung Midnight 
Commander with SAK with no success. Top showed that near 100% CPU was sucked 
by mc. Plain old kill <pid> form another vc killed it, and login prompt 
appeared.

Isn't SAK supposed to be able to kill anything on a vc?
--
vda
