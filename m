Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262455AbSJETXj>; Sat, 5 Oct 2002 15:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262457AbSJETXj>; Sat, 5 Oct 2002 15:23:39 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:56474 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S262455AbSJETXi>; Sat, 5 Oct 2002 15:23:38 -0400
Message-ID: <20021005192803.17276.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-15"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Paolo Ciarrocchi" <ciarrocchi@linuxmail.org>
To: <akpm@digeo.com>
Cc: conman@kolivas.net, linux-kernel@vger.kernel.org,
       rmaureira@alumno.inacap.cl, rcastro@ime.usp.br
Date: Sun, 06 Oct 2002 03:28:03 +0800
Subject: Re: [BENCHMARK] contest 0.50 results to date
X-Originating-Ip: 193.76.202.244
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Morton <akpm@digeo.com>
> I think I'm going to have to be reminded what "Loads" and "LCPU"
> mean, please.
>From an email of Con:
The "loads" variable presented is an internal number (the absolute value is not important) and makes comparisons easier. The LCPU% is the cpu%
the load used while running. 
Note if you look for example at process_load the CPU% + LCPU% can be >100 because the load runs for longer than the kernel compile. 
However, this has been accounted for in the "loads" result, to take into account the variable extra duration the load runs relative to the kernel compile. "


> What is "2.4.19-0.24pre4"?
My fault ;-(
2.4.19-0.24pre4 is a compressed cache kernel.

Ciao,
Paolo
-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
