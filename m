Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318079AbSHNNZ2>; Wed, 14 Aug 2002 09:25:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318101AbSHNNZ2>; Wed, 14 Aug 2002 09:25:28 -0400
Received: from cpe-66-1-218-52.fl.sprintbbd.net ([66.1.218.52]:34834 "EHLO
	daytona.compro.net") by vger.kernel.org with ESMTP
	id <S318079AbSHNNZ2>; Wed, 14 Aug 2002 09:25:28 -0400
Message-ID: <3D5A5BB9.DEDEF97D@compro.net>
Date: Wed, 14 Aug 2002 09:31:37 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-lcrs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: irqbalance 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Will this prevent me from affinitizing irqs via the proc fs or prevent me from
doing it from
within a module? I tried an irqbalance patch for the p4's for 2.4.18 and it did
in fact prevent me from doing this. This would be bad for those who use this irq
affinitizing thing
along with process affinity for real-time determinism improvements. 

Regards
Mark
