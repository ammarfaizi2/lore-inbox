Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265373AbTCELKS>; Wed, 5 Mar 2003 06:10:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265414AbTCELKS>; Wed, 5 Mar 2003 06:10:18 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:17925 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S265373AbTCELKR>; Wed, 5 Mar 2003 06:10:17 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303051122.h25BMC1O000759@81-2-122-30.bradfords.org.uk>
Subject: Re: Those ruddy punctuation fixes
To: rmk@arm.linux.org.uk (Russell King)
Date: Wed, 5 Mar 2003 11:22:12 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030305111015.B8883@flint.arm.linux.org.uk> from "Russell King" at Mar 05, 2003 11:10:15 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Could we stop fix^wbreaking this stuff please.  GCC 3.2.2:
> 
> include/asm/proc-fns.h:128:39: missing terminating ' character

Ah, but the 'real' fix is to never use a word which requires an
apostrophe - E.G.

I can't apply this patch -> I can not apply this patch
Russell's patch -> The patch which Russell wrote

:-)

John.
