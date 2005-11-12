Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932352AbVKLPQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932352AbVKLPQy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Nov 2005 10:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932391AbVKLPQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Nov 2005 10:16:53 -0500
Received: from web60221.mail.yahoo.com ([209.73.178.109]:15965 "HELO
	web60221.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932352AbVKLPQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Nov 2005 10:16:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=WfTyG4keAZxd2HVyuriqIFvRrLQ9Jw6q6Ce2t0WPdZRjwUKpnFseiFN+9iIR2Kieqvg0Zgofu7CPGb3tkbRVnC/cJJE9LS3mkICvmzwQtMb+uSraZjl6xeHTNqMexva2yTiCwxjmM5Pwb+OAtfvTDUx4jfjB0QV8bgmAasUscnA=  ;
Message-ID: <20051112151652.83848.qmail@web60221.mail.yahoo.com>
Date: Sat, 12 Nov 2005 07:16:52 -0800 (PST)
From: anil dahiya <ak_ait@yahoo.com>
Subject: making makefile for 2.6 kernel 
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
In-Reply-To: <20051112011006.GD7991@shell0.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi 
I want to makefile for my kernel module..
1.c 2.c 3.c files are places in /home/anil folder but
these files contain .h (hearder)files from 3 different
directory 1) /home/include 2) /root/incluent 3)
/opt/include

can u suggest me a makefile to generate a common
module target.ko using these .C and .h files.

Thanks in advance
Regards,
anil


		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
