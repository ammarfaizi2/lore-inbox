Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318033AbSHVXMw>; Thu, 22 Aug 2002 19:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318038AbSHVXMv>; Thu, 22 Aug 2002 19:12:51 -0400
Received: from node187121.liebert.com ([65.209.187.121]:35593 "EHLO
	mars1.marsbase.com") by vger.kernel.org with ESMTP
	id <S318033AbSHVXMv>; Thu, 22 Aug 2002 19:12:51 -0400
Message-ID: <001f01c24a31$d4956a50$493e1f7e@IRV429>
From: "Omar" <omar@natasha.org>
To: <linux-kernel@vger.kernel.org>
References: <OFE708D02D.C1935D57-ON85256C1D.006DDF9E@pok.ibm.com>
Subject: serial driver maintaner
Date: Thu, 22 Aug 2002 16:15:19 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2462.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2462.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I've been trying to find out information on the Linux serial driver.  The
maintainer hasn't updated his web site in a long time, does anyone know if
he's still maintaining it ??

I am asking because I have a uart that isn't directly supported in the
driver and I may need to add support for it, but I don't want to modify the
serial driver unless it can be included in the main distribution channel.

The uart in question is a TI 16C752.   I've tried using it with 16750 and
16650 settings,and it occasionally drops characters or receives duplicate
characters.


