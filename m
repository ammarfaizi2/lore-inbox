Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262906AbTCQGVM>; Mon, 17 Mar 2003 01:21:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262908AbTCQGVM>; Mon, 17 Mar 2003 01:21:12 -0500
Received: from c17870.thoms1.vic.optusnet.com.au ([210.49.248.224]:56552 "EHLO
	mail.kolivas.org") by vger.kernel.org with ESMTP id <S262906AbTCQGVL>;
	Mon, 17 Mar 2003 01:21:11 -0500
From: Con Kolivas <kernel@kolivas.org>
To: Joshua Kwan <joshk@triplehelix.org>
Subject: Re: Weirdness with 2.4.20-ck4
Date: Mon, 17 Mar 2003 17:32:02 +1100
User-Agent: KMail/1.5
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>
References: <20030316201124.GA2849@triplehelix.org> <200303171509.34696.kernel@kolivas.org> <20030317041553.GA1186@triplehelix.org>
In-Reply-To: <20030317041553.GA1186@triplehelix.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303171732.02778.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Mar 2003 15:15, Joshua Kwan wrote:
> On Mon, Mar 17, 2003 at 03:09:23PM +1100, Con Kolivas wrote:
> > Using it on a server box? You should reverse patch the desktop tuning
> > (patch 010) at the very least. Your throughput will be higher without
> > that and it may well be responsible for the hang.
>
> I'm running 2.4.20-rmap15e for now, but I'm quite sure I only had 001,
> 002, and 003.
>
> 001_o1_pe_ll_030206_ck_2.4.20.patch.bz2
> 002_aavm_030226_ck_2.4.20.patch.bz2
> 003_rl2_021215_ck.2.4.20.patch.bz2

Ok. Well I don't recommend the rl2 patch, but I would recommend the first two. 

Con
