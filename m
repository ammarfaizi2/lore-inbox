Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262213AbSJZPI2>; Sat, 26 Oct 2002 11:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262214AbSJZPI2>; Sat, 26 Oct 2002 11:08:28 -0400
Received: from bohnice.netroute.lam.cz ([212.71.169.62]:30958 "EHLO
	shunka.yo.cz") by vger.kernel.org with ESMTP id <S262213AbSJZPI1>;
	Sat, 26 Oct 2002 11:08:27 -0400
Message-ID: <001001c27d02$6297fe50$4500a8c0@cybernet.cz>
From: "=?iso-8859-2?B?VmxhZGlt7XIgVPhlYmlja/0=?=" <guru@cimice.yo.cz>
To: <linux-kernel@vger.kernel.org>
Subject: Swap doesn't work
Date: Sat, 26 Oct 2002 17:14:01 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've made my linux-from-scratch with latest stable (2.4.19) kernel, made
swap, turned it on but it doesn't work. It seems it does but when there's
not enough memory, the system crashes. Either it kills the application
desiring more memory (gcc or something) or crashes the kernel with memory
dump. Neither the 2.4.20-pre5-ac3 helped.

Thank you for your help,

Vladimir Trebicky

--
Vladimir Trebicky
guru@cimice.yo.cz

