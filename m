Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282939AbRLDJR0>; Tue, 4 Dec 2001 04:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282943AbRLDJRP>; Tue, 4 Dec 2001 04:17:15 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:8387 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S282939AbRLDJQ6>; Tue, 4 Dec 2001 04:16:58 -0500
Date: Tue, 4 Dec 2001 11:20:57 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: <computerguy8@hotmail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: Problem with adaptec 2100S under Redhat Linux 7.1 on Tyan S2460
Message-ID: <Pine.LNX.4.33.0112041114430.23651-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a 2100S installed as a root device on RH7.1. In order to get it
working i used Adaptec's i2o driver instead of the generic one, to do this
i compiled a custom kernel and dropped it into the RH bootdisks, the
kernel i used was 2.4.10-ac11. I wrote an article for Linux Gazette on how
to do this (http://www.linuxgazette.com/issue73/mwaikambo.html)

HTH,
	Zwane Mwaikambo


