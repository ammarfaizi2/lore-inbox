Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310226AbSCFW1S>; Wed, 6 Mar 2002 17:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310223AbSCFW1J>; Wed, 6 Mar 2002 17:27:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:27399 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S310241AbSCFW1A>; Wed, 6 Mar 2002 17:27:00 -0500
Subject: Re: [PATCH] Rework of /proc/stat
To: jean-eric.cuendet@linkvest.com (Jean-Eric Cuendet)
Date: Wed, 6 Mar 2002 22:42:16 +0000 (GMT)
Cc: jean-eric.cuendet@linkvest.com (Jean-Eric Cuendet),
        linux-kernel@vger.kernel.org
In-Reply-To: <3C86553E.3070608@linkvest.com> from "Jean-Eric Cuendet" at Mar 06, 2002 06:43:26 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16ik6y-0008Qf-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've made a new version of IO statistics in kstat that remove the
> previous limitations of MAX_MAJOR. I've made tests on my machine only, so could someone test it, please?
> Feedback welcome.

Any reason for preferring this over the sard patches in -ac ?

