Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312593AbSCVBF7>; Thu, 21 Mar 2002 20:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312594AbSCVBFt>; Thu, 21 Mar 2002 20:05:49 -0500
Received: from relay.softcomca.com ([168.144.1.68]:32786 "EHLO
	relay2.softcomca.com") by vger.kernel.org with ESMTP
	id <S312593AbSCVBFk> convert rfc822-to-8bit; Thu, 21 Mar 2002 20:05:40 -0500
X-Originating-IP: 4.20.162.6
X-URL: http://www.mail2web.com/
Subject: max number of threads on a system
From: "joeja@mindspring.com" <joeja@mindspring.com>
Date: Thu, 21 Mar 2002 20:05:39 -0500
To: "linux-kernel@vger.redhat.com" <linux-kernel@vger.kernel.org>
Reply-To: joeja@mindspring.com
X-Priority: 3
X-MSMail-Priority: Normal
Content-Transfer-Encoding: 7BIT
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Mailer: JMail 3.7.0 by Dimac (www.dimac.net)
Message-ID: <RELAY2HXrsOZoybKw2N00004110@relay2.softcomca.com>
X-OriginalArrivalTime: 22 Mar 2002 01:05:48.0203 (UTC) FILETIME=[B3C077B0:01C1D13D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What limits the number of threads one can have on a Linux system?

I have a simple program that creates an array of threads and it locks up at the creation of somewhere between 250 and 275 threads.

The program just hangs indefinately unless a Control-C is hit.

How can I increase this number or can I?

Thanks, Joe 

--------------------------------------------------------------------
mail2web - Check your email from the web at
http://mail2web.com/ .

