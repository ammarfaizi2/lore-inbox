Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263943AbRFHJ12>; Fri, 8 Jun 2001 05:27:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263944AbRFHJ1S>; Fri, 8 Jun 2001 05:27:18 -0400
Received: from Prins.externet.hu ([212.40.96.161]:27400 "EHLO
	prins.externet.hu") by vger.kernel.org with ESMTP
	id <S263943AbRFHJ1D>; Fri, 8 Jun 2001 05:27:03 -0400
Date: Fri, 8 Jun 2001 11:27:00 +0200 (CEST)
From: Boszormenyi Zoltan <zboszor@externet.hu>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] softirq-2.4.6-C3
Message-ID: <Pine.LNX.4.02.10106081122580.2007-100000@prins.externet.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I tried this and do_softirq is still unresolved symbol if
CONFIG_MODVERSIONS is set to y. Works ok if not.

linux-2.4.6-pre1 + softirq-2.4.6-B4 + softirq-2.4.6-C3.

Regards,
Zoltan Boszormenyi


