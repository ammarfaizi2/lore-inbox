Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284536AbRLPJKa>; Sun, 16 Dec 2001 04:10:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284570AbRLPJKT>; Sun, 16 Dec 2001 04:10:19 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:23962 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S284536AbRLPJKK>; Sun, 16 Dec 2001 04:10:10 -0500
Date: Sun, 16 Dec 2001 11:11:56 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: <zwane@netfinity.realnet.co.sz>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][OOPS] loop block device induced on 2.5.1-pre11+HIGHMEM
In-Reply-To: <Pine.LNX.4.33.0112161017550.4185-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.LNX.4.33.0112161111130.17367-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another question, how did we manage to hit the bounce stuff when i mounted
a loopback filesystem? regular mounts are fine.

Cheers,
	Zwane Mwaikambo


