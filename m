Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132834AbRD2E4k>; Sun, 29 Apr 2001 00:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132831AbRD2E4a>; Sun, 29 Apr 2001 00:56:30 -0400
Received: from geos.coastside.net ([207.213.212.4]:11684 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S135573AbRD2E4X>; Sun, 29 Apr 2001 00:56:23 -0400
Mime-Version: 1.0
Message-Id: <p05100304b71121ec85c7@[207.213.213.109]>
In-Reply-To: <200104281804.f3SI4ar368494@saturn.cs.uml.edu>
In-Reply-To: <200104281804.f3SI4ar368494@saturn.cs.uml.edu>
Date: Sat, 28 Apr 2001 18:43:50 -0700
To: linux-kernel@vger.kernel.org
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: 2.4 and 2GB swap partition limit
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 2:04 PM -0400 2001-04-28, Albert D. Cahalan wrote:
>It is a disaster waiting to happen. Instead of having the offending
>process get killed, your machine could suffer extreme thrashing.
>
>Have enough swap for idle processes and no more.

Let's altogether now say "working set".

(Does Linux swap out text, by the way, he asks ignorantly?)
-- 
/Jonathan Lundell.
