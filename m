Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932533AbVKWV0k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932533AbVKWV0k (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 16:26:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbVKWV0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 16:26:40 -0500
Received: from silver.veritas.com ([143.127.12.111]:28558 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932533AbVKWV0h
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 16:26:37 -0500
Date: Wed, 23 Nov 2005 21:26:45 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Michael Krufky <mkrufky@linuxtv.org>
cc: Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       Adrian Bunk <bunk@stusta.de>, Johannes Stezenbach <js@linuxtv.org>,
       Sam Ravnborg <sam@ravnborg.org>, Kirk Lapray <kirk.lapray@gmail.com>
Subject: Re: Linux 2.6.15-rc2
In-Reply-To: <4384D0EC.5050709@linuxtv.org>
Message-ID: <Pine.LNX.4.61.0511232122300.13837@goblin.wat.veritas.com>
References: <Pine.LNX.4.64.0511191934210.8552@g5.osdl.org>
 <200511231436.54136.gene.heskett@verizon.net> <4384C909.4040107@m1k.net>
 <200511231514.17157.gene.heskett@verizon.net> <4384D0EC.5050709@linuxtv.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 23 Nov 2005 21:26:36.0729 (UTC) FILETIME=[95A30A90:01C5F074]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Nov 2005, Michael Krufky wrote:
> > > 
> > > First off, Gene, I am still under the impression that both v4l and dvb
> > > subsystems are broken under 2.6.15 due to the memory bugs... I don't
> > > know if Hugh Dickins fixed those yet or not.

They should be fixed in today's 2.6.15-rc2-git3
(aside from a couple of patches to drivers/char/drm coming later).
If you still have problems you think I'm responsible for, let me know.

Hugh
