Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262770AbSI1J53>; Sat, 28 Sep 2002 05:57:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262771AbSI1J53>; Sat, 28 Sep 2002 05:57:29 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:20219 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S262770AbSI1J52>; Sat, 28 Sep 2002 05:57:28 -0400
Subject: Re: System very unstable
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Felix Seeger <felix.seeger@gmx.de>
Cc: Thunder from the hill <thunder@lightweight.ods.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <200209281155.32668.felix.seeger@gmx.de>
References: <Pine.LNX.4.44.0209280348150.7827-100000@hawkeye.luckynet.adm> 
	<200209281155.32668.felix.seeger@gmx.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 28 Sep 2002 11:08:30 +0100
Message-Id: <1033207710.17777.31.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-09-28 at 10:55, Felix Seeger wrote:
> But I have a Desktop system. I play games. I can't remove that driver.
> I am running 2.4.19 since it is out and never had such problems with the 
> NVDriver.

What we want to know is: does it crash with no NVdriver involved from
boot. Thats the one thing that says 'Maybe the Linux kernel has a
problem' and means people can hunt it down

I'd still start with the hw tests first just because of the description
you give. However if they seem ok and it wont crash without the NVdriver
loaded - talk to Nvidia not us 8)

