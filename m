Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317363AbSFLWy4>; Wed, 12 Jun 2002 18:54:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317361AbSFLWyy>; Wed, 12 Jun 2002 18:54:54 -0400
Received: from bgp01387421bgs.brodwy01.nm.comcast.net ([68.35.130.254]:35456
	"EHLO www.tojabr.com") by vger.kernel.org with ESMTP
	id <S317362AbSFLWyw>; Wed, 12 Jun 2002 18:54:52 -0400
Date: Wed, 12 Jun 2002 16:55:49 -0600 (MDT)
From: Tom Bradley <tojabr@tojabr.com>
To: <linux-kernel@vger.kernel.org>
Subject: procfs documentation
In-Reply-To: <1023921856.1476.64.camel@sinai>
Message-ID: <Pine.LNX.4.33.0206121651160.2615-100000@www.tojabr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Where can I find documentation that explains all the entries in procfs?

man 5 procfs is out of date and doesn't match.
Documentation/filesystems/proc.txt is incomplete.

I am writing a user-land GUI based program that allows user to easily read
the procfs but I can't find info on all the entries.

Tom


