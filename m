Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271873AbRH1SiR>; Tue, 28 Aug 2001 14:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271876AbRH1SiI>; Tue, 28 Aug 2001 14:38:08 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:49416 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S271873AbRH1Shy>; Tue, 28 Aug 2001 14:37:54 -0400
Message-ID: <3B8BE50B.52BE5306@zip.com.au>
Date: Tue, 28 Aug 2001 11:38:03 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.8-ac9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Theurer <habanero@us.ibm.com>
CC: Roberto Nibali <ratz@tac.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Journal Filesystem Comparison on Netbench
In-Reply-To: <3B8A6122.3C784F2D@us.ibm.com> <3B8B6CEF.17C616C0@tac.ch> <3B8BB895.179331CE@us.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Theurer wrote:
> 
> Does ext3 have any spin locks with interrupts disabled?
> 

No.  But raid1 does.

-
