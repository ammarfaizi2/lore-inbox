Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129666AbRCAPzn>; Thu, 1 Mar 2001 10:55:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbRCAPze>; Thu, 1 Mar 2001 10:55:34 -0500
Received: from kanga.kvack.org ([216.129.200.3]:17931 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id <S129666AbRCAPzZ>;
	Thu, 1 Mar 2001 10:55:25 -0500
Date: Thu, 1 Mar 2001 10:51:22 -0500 (EST)
From: <kernel@kvack.org>
To: Ofer Fryman <ofer@shunra.co.il>
cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Intel-e1000 for Linux 2.0.36-pre14
In-Reply-To: <F1629832DE36D411858F00C04F24847A11DECF@SALVADOR>
Message-ID: <Pine.LNX.3.96.1010301104826.2411E-100000@kanga.kvack.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2001, Ofer Fryman wrote:

> I need a giga fiber PMC cards for linux2.0.36-pre14, the only cards I know
> are either Intel based or level-one lxt-1001 card, the level-one lxt-1001
> has very bad performance so I cannot use it.

Well, 2.0 kernels are sufficiently old that there's little likelyhood of
newer gige drivers supporting them unless you do the work yourself.  My
personal recommendation would be moving to a 2.2 or 2.4 kernel and using
an Acenic.

		-bem

