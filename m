Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269689AbSIRTSq>; Wed, 18 Sep 2002 15:18:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269690AbSIRTSq>; Wed, 18 Sep 2002 15:18:46 -0400
Received: from mailrelay1.lanl.gov ([128.165.4.101]:38839 "EHLO
	mailrelay1.lanl.gov") by vger.kernel.org with ESMTP
	id <S269689AbSIRTSp>; Wed, 18 Sep 2002 15:18:45 -0400
Subject: Re: 2.5.36 oops at boot
From: Steven Cole <elenstev@mesatop.com>
To: Gregoire Favre <greg@ulima.unil.ch>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020918120321.GA6167@ulima.unil.ch>
References: <20020918120321.GA6167@ulima.unil.ch>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2-5mdk 
Date: 18 Sep 2002 13:20:06 -0600
Message-Id: <1032376806.11913.130.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-09-18 at 06:03, Gregoire Favre wrote:
> Hello,

> kernel BUG at sched.c:944!

Try this fix archived here. Should work with and without PREEMPT.
http://marc.theaimsgroup.com/?l=linux-kernel&m=103236178722206&w=2

Steven


