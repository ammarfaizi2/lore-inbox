Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318858AbSIIUVD>; Mon, 9 Sep 2002 16:21:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318866AbSIIUVD>; Mon, 9 Sep 2002 16:21:03 -0400
Received: from h195202190178.med.cm.kabsi.at ([195.202.190.178]:17822 "EHLO
	phobos.hvrlab.org") by vger.kernel.org with ESMTP
	id <S318858AbSIIUVC>; Mon, 9 Sep 2002 16:21:02 -0400
Subject: Re: Patch?: linux-2.5.33/drivers/block/loop.c update
From: Herbert Valerio Riedel <hvr@hvrlab.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020909052047.A1157@baldur.yggdrasil.com>
References: <20020909052047.A1157@baldur.yggdrasil.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Sep 2002 22:25:37 +0200
Message-Id: <1031603138.2243.19.camel@janus.txd.hvrlab.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-09-09 at 14:20, Adam J. Richter wrote:
> have time to retest for a little while, so I thought I ought to post
> this update in case anyone else wants to comment or test.

I've integrated adam's loop.diff into

http://www.kernel.org/pub/linux/kernel/crypto/v2.5/patch-int-2.5.33.2.bz2

in case anyone wants an all-in-one patch...

regards,
-- 
Herbert Valerio Riedel       /    Phone: (EUROPE) +43-1-58801-18840
Email: hvr@hvrlab.org       /    Finger hvr@gnu.org for GnuPG Public Key
GnuPG Key Fingerprint: 7BB9 2D6C D485 CE64 4748  5F65 4981 E064 883F
4142

