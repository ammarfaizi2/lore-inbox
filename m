Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750843AbWBCOOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843AbWBCOOu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 09:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750842AbWBCOOu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 09:14:50 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:59806 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750834AbWBCOOt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 09:14:49 -0500
Date: Fri, 3 Feb 2006 15:14:39 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux@horizon.com
cc: davej@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: discriminate single bit error hardware failure from slab
 corruption.
In-Reply-To: <20060203092533.13547.qmail@science.horizon.com>
Message-ID: <Pine.LNX.4.61.0602031512290.7991@yvahk01.tjqt.qr>
References: <20060203092533.13547.qmail@science.horizon.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Um... case values are allowed to be expressions.

Whatever they are, they must be able to be reduced to an integer constant.


Jan Engelhardt
-- 
