Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133091AbRDLPD1>; Thu, 12 Apr 2001 11:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135191AbRDLPDS>; Thu, 12 Apr 2001 11:03:18 -0400
Received: from goliath.siemens.de ([194.138.37.131]:141 "EHLO
	goliath.siemens.de") by vger.kernel.org with ESMTP
	id <S133091AbRDLPDA>; Thu, 12 Apr 2001 11:03:00 -0400
X-Envelope-Sender-Is: ulrich.lauther@mchp.siemens.de (at relayer goliath.siemens.de)
From: Ulrich Lauther <ulrich.lauther@mchp.siemens.de>
Message-Id: <200104121502.f3CF2r914576@emma.mchp.siemens.de>
Subject: Re: 2.4.2 bug in handling vfat? (fwd)
To: linux-kernel@vger.kernel.org
Date: Thu, 12 Apr 2001 17:02:53 +0200 (MET DST)
Reply-To: Ulrich.Lauther@mchp.siemens.de
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi,
> 
> I think that it is the bug of FAT-fs.
> Please try the following patch.
> 
thanks a lot, the patch fixes the problem

-- 
	-ulrich lauther

----------------------------------------------------------------------------
Ulrich Lauther          ph: +49 89 636 48834 fx: ... 636 42284
Siemens CT SE 6         Internet: Ulrich.Lauther@mchp.siemens.de
