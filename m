Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272449AbRIRSPf>; Tue, 18 Sep 2001 14:15:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273131AbRIRSPZ>; Tue, 18 Sep 2001 14:15:25 -0400
Received: from 63-151-64-156.hsacorp.net ([63.151.64.156]:50701 "EHLO
	boojiboy.eorbit.net") by vger.kernel.org with ESMTP
	id <S272449AbRIRSPT>; Tue, 18 Sep 2001 14:15:19 -0400
From: chris@boojiboy.eorbit.net
Message-Id: <200109181912.MAA11723@boojiboy.eorbit.net>
Subject: pci-pc.c build compiler warnings
To: linux-kernel@vger.kernel.org
Date: Tue, 18 Sep 2001 12:12:40 -0700 (PDT)
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

building 2.4.9-ac10 (it happened in earlier builds too)
I get these messages at the pci-pc.c step:

{standard input}: Assembler messages:
{standard input}: 1062: Warning: indirect lcall without '*'
{standard input}: 1147: Warning: indirect lcall without '*'
{standard input}: 1232: Warning: indirect lcall without '*'
{standard input}: 1306: Warning: indirect lcall without '*'
{standard input}: 1317: Warning: indirect lcall without '*'
{standard input}: 1328: Warning: indirect lcall without '*'
{standard input}: 1405: Warning: indirect lcall without '*'
{standard input}: 1417: Warning: indirect lcall without '*'
{standard input}: 1429: Warning: indirect lcall without '*'
{standard input}: 1898: Warning: indirect lcall without '*'
{standard input}: 1991: Warning: indirect lcall without '*'


--Chris
