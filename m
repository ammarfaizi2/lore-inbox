Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbTKDPvS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 10:51:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262333AbTKDPvS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 10:51:18 -0500
Received: from baloney.puettmann.net ([194.97.54.34]:9134 "EHLO
	baloney.puettmann.net") by vger.kernel.org with ESMTP
	id S262324AbTKDPvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 10:51:17 -0500
To: linux-kernel@vger.kernel.org
CC: Dave Jones <davej@redhat.com>
From: Ruben Puettmann <ruben@puettmann.net>
Subject: Re: Suspend and AGP in 2.6.0-test9
In-Reply-To: <NN6b.pY.5@gated-at.bofh.it>
References: <NMa8.7uR.11@gated-at.bofh.it> <NN6b.pY.5@gated-at.bofh.it>
Reply-To: ruben@puettmann.net
Date: Tue, 4 Nov 2003 16:50:16 +0100
Message-Id: <E1AH3Rg-00033v-00@baloney.puettmann.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        hy,

> Suspend/Resume code in agpgart is virtually non-existant.

Do you know if there is some work in progress? Without suspend and
resume with XFree most laptop users will not be happy with 2.6.

Here on Thinkpad with ATI 7500 I can suspend but not resume if XFree is
enabled.

                Ruben

-- 
Ruben Puettmann
ruben@puettmann.net
http://www.puettmann.net
