Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131521AbRBNX47>; Wed, 14 Feb 2001 18:56:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131519AbRBNX4s>; Wed, 14 Feb 2001 18:56:48 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:5395 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131379AbRBNX4h>; Wed, 14 Feb 2001 18:56:37 -0500
Subject: Re: aic7xxx plans
To: jamagallon@able.es (J . A . Magallon)
Date: Wed, 14 Feb 2001 23:57:13 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
In-Reply-To: <20010215005027.C21100@werewolf.able.es> from "J . A . Magallon" at Feb 15, 2001 12:50:27 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14TBnQ-0006Vc-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are there any plans of switching the drivers ? I have tried to patch 2.4.1-acX,
> but there are rejected hunks and had no time to patch manually and make a
> diff.

I dont plan to switch them yet a while, and never for 2.2. For 2.5 its a
total nobrainer that we move to Justins driver or move to Justins driver post
crudfixing that may be needed to make it clean and Linuxish

