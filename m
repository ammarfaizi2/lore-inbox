Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289838AbSAPDXV>; Tue, 15 Jan 2002 22:23:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289835AbSAPDXL>; Tue, 15 Jan 2002 22:23:11 -0500
Received: from mail.webmaster.com ([216.152.64.131]:49344 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S289751AbSAPDXC> convert rfc822-to-8bit; Tue, 15 Jan 2002 22:23:02 -0500
From: David Schwartz <davids@webmaster.com>
To: <linux-kernel@vger.kernel.org>
X-Mailer: PocoMail 2.51 (995) - Registered Version
Date: Tue, 15 Jan 2002 19:22:59 -0800
Subject: likely/unlikely
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-ID: <20020116032300.AAA27749@shell.webmaster.com@whenever>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	By the way, has anybody actually benchmarked these macros to see if they 
make any difference. I did a few quick inexact benchmarks on test code and 
found that in most cases there was no difference and in some cases code was 
made worse.

-- 
David Schwartz
<davids@webmaster.com>


