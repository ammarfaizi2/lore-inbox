Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267449AbTB1Dxx>; Thu, 27 Feb 2003 22:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267456AbTB1Dxx>; Thu, 27 Feb 2003 22:53:53 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:10125 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267449AbTB1Dxw>; Thu, 27 Feb 2003 22:53:52 -0500
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: miquels@cistron-office.nl, linux-kernel@vger.kernel.org
Subject: Re: Patch: 2.5.62 devfs shrink
References: <200302280314.TAA11682@baldur.yggdrasil.com>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 28 Feb 2003 13:03:16 +0900
In-Reply-To: <200302280314.TAA11682@baldur.yggdrasil.com>
Message-ID: <buou1ep8323.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> writes:
> For example, should the directory names be singular or plural
> (/dev/loop or /dev/loops, /dev/disk or /dev/disks)?  I would recommend
> signular because it is less English-centric.

I think singular is also far more common in existing [unix] practice.

-Miles
-- 
`Cars give people wonderful freedom and increase their opportunities.
 But they also destroy the environment, to an extent so drastic that
 they kill all social life' (from _A Pattern Language_)
