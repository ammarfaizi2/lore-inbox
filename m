Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288255AbSAVFND>; Tue, 22 Jan 2002 00:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288716AbSAVFM4>; Tue, 22 Jan 2002 00:12:56 -0500
Received: from paloma12.e0k.nbg-hannover.de ([62.181.130.12]:53230 "HELO
	paloma12.e0k.nbg-hannover.de") by vger.kernel.org with SMTP
	id <S288255AbSAVFMp>; Tue, 22 Jan 2002 00:12:45 -0500
Content-Type: text/plain;
  charset="iso-8859-15"
From: Dieter =?iso-8859-15?q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>
Organization: DN
To: rwhron@earthlink.net
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Tue, 22 Jan 2002 06:12:37 +0100
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020114165430.421B01ED55@Cantor.suse.de> <20020114182019.E22791@athlon.random>
In-Reply-To: <20020114182019.E22791@athlon.random>
Cc: Robert Love <rml@tech9.net>, Ingo Molnar <mingo@elte.hu>,
        Andrea Arcangeli <andrea@suse.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20020122051248Z288255-13996+9603@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 22. January 2002 01:44, you wrote:
> 2.4.18pre2a2    aa vm and low-latency included
> 2.4.18-pre3
> 2.4.18-pre3ll   low-latency patch
> 2.4.18-pre3pelb preempt and lockbreak patches
>
> It appears 2.4.18pre2aa2 is the best overall, and the
> low-latency patch does better than preempt in most cases.

These are _NOT_ new results.
But you should bench 2.4.18pre2aa2 + preempt + lock-break or
2.4.18-pre4 + O(1) J4 + 10_vm-22 (aa2) + preempt + lock-break...

That's what I'm doing all night long for Robert...

Regards,
	Dieter 

-- 
Dieter Nützel
Graduate Student, Computer Science

University of Hamburg
Department of Computer Science
@home: Dieter.Nuetzel@hamburg.de
