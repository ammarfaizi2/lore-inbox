Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263218AbSJCJcx>; Thu, 3 Oct 2002 05:32:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263219AbSJCJcx>; Thu, 3 Oct 2002 05:32:53 -0400
Received: from 213-187-164-2.dd.nextgentel.com ([213.187.164.2]:43909 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S263218AbSJCJcw> convert rfc822-to-8bit;
	Thu, 3 Oct 2002 05:32:52 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: O(1) scheduler for 2.4.(19|20-pre.)?
Date: Thu, 3 Oct 2002 11:48:23 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200210031148.23823.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

1. Do I need the O(1) scheduler to run a heavily I/O bound server application 
with some 200-500 concurrent threads?
2. If so - can I find the O(1) scheduler somewhere for 2.4?

roy
-- 
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

