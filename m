Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262490AbTCRQOA>; Tue, 18 Mar 2003 11:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262494AbTCRQOA>; Tue, 18 Mar 2003 11:14:00 -0500
Received: from smtp2.EUnet.yu ([194.247.192.51]:22961 "EHLO smtp2.eunet.yu")
	by vger.kernel.org with ESMTP id <S262490AbTCRQN7>;
	Tue, 18 Mar 2003 11:13:59 -0500
From: Toplica Tanaskovic <toptan@EUnet.yu>
To: "Felipe Alfaro Solana" <felipe_alfaro@linuxmail.org>
Subject: Re: 2.5.6X & 2.5.59 Interactivity & XMMS audio skipping
Date: Tue, 18 Mar 2003 17:23:00 +0100
User-Agent: KMail/1.5
References: <20030318104941.28605.qmail@linuxmail.org>
In-Reply-To: <20030318104941.28605.qmail@linuxmail.org>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Disposition: inline
Message-Id: <200303181723.00635.toptan@EUnet.yu>
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by smtp2.eunet.yu id h2IGOox11508
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dana utorak 18. mart 2003. 11:49, Felipe Alfaro Solana je napisao/la:
> Hi,
>
> While playing with 2.5.65 and 2.5.64-mm8 I've been able
> to reproduce audio skipping with XMMS while moving a
> large window on my KDE desktop (no other CPU-bound
> process except "kdeinit" waking up periodically to steal
> 1-3% CPU). What's really curious is that after some time,
> the scheduler seems to adjust in such a way that I can't
> reproduce the audio skip anymore easily.
>
	I do not have skipping, but if I play short samples eg. less than two 
seconds, I get same sample repeated abot 7-8 times. Longer ones play OK 
except last sec or two, than last two seconds which are repeated same way as 
short samples.

	This is happening since 2.5.59, but not in 2.5.52. 2.5.53-2.5.58 not tested.
-- 
Pozdrav,
Tanasković Toplica


