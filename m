Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318435AbSHQISb>; Sat, 17 Aug 2002 04:18:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318487AbSHQISb>; Sat, 17 Aug 2002 04:18:31 -0400
Received: from f232.law12.hotmail.com ([64.4.19.232]:37386 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S318435AbSHQISb>;
	Sat, 17 Aug 2002 04:18:31 -0400
X-Originating-IP: [128.139.197.27]
From: "nada shalabi" <nadashshsh@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: important question!
Date: Sat, 17 Aug 2002 08:22:24 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F232Dd3OJXsNQptgFrY00000068@hotmail.com>
X-OriginalArrivalTime: 17 Aug 2002 08:22:24.0590 (UTC) FILETIME=[3726E6E0:01C245C7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
i want to add a comprissing syscall in the linux kernel in order to improve 
the work of the swapper.
The commprissing function and the decomprissing one take a buffer as an 
argument.now i am trying to find the right line to insert the compriss and 
decompriis in  i meen the place in thre code before the buffer of data 
became a page and after a page become a buffer od data.
i still searching and reading the linux code i think my answer should be in 
page_io.c.
please help me i need the answer today.
thanx in advance
nada shalabi





_________________________________________________________________
Join the world’s largest e-mail service with MSN Hotmail. 
http://www.hotmail.com

