Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270742AbRHNSyd>; Tue, 14 Aug 2001 14:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270737AbRHNSyO>; Tue, 14 Aug 2001 14:54:14 -0400
Received: from ams8uucp0.ams.ops.eu.uu.net ([212.153.111.69]:48547 "EHLO
	ams8uucp0.ams.ops.eu.uu.net") by vger.kernel.org with ESMTP
	id <S270733AbRHNSxx>; Tue, 14 Aug 2001 14:53:53 -0400
Date: Tue, 14 Aug 2001 16:17:53 +0200 (CEST)
From: kees <kees@schoen.nl>
To: <linux-kernel@vger.kernel.org>
Subject: Q. wipe behaves different (mem-mapped file)
Message-ID: <Pine.LNX.4.33.0108141615440.13223-100000@schoen3.schoen.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

wipe works different on 2.4.8 wrt 2.4.7
that is it works normal and fast on 2.4.7 // slow on 2.4.8
it uses memory mapped file access

Kees



