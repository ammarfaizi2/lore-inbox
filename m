Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261896AbSJIQgr>; Wed, 9 Oct 2002 12:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261899AbSJIQgr>; Wed, 9 Oct 2002 12:36:47 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:11023 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S261896AbSJIQgq>; Wed, 9 Oct 2002 12:36:46 -0400
Message-Id: <200210091637.g99Gbmp30784@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: linux-kernel@vger.kernel.org
Subject: Looking for testers with these NICs
Date: Wed, 9 Oct 2002 19:31:17 -0200
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm looking for people who is brave (or stupid) enough to try 2.5
and who has network card(s) driven by one of the following drivers:

3c505.c
3c515.c
82596.c
at1700.c
depca.c
ewrk3.c
lp486e.c
ni5010.c
ni65.c
smc9194.c

These drivers currently don't compile. I'm fixing them but
can't test on a live hardware. Anyone?
--
vda
