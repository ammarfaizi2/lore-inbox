Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266848AbTAIRQP>; Thu, 9 Jan 2003 12:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266851AbTAIRQP>; Thu, 9 Jan 2003 12:16:15 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:6380 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266848AbTAIRQO>;
	Thu, 9 Jan 2003 12:16:14 -0500
Date: Thu, 9 Jan 2003 17:22:29 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PATCH: IPMI driver
Message-ID: <20030109172229.GA27288@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200301090332.h093WML05981@hera.kernel.org> <20030109164407.GA26195@codemonkey.org.uk> <1042135594.27796.37.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1042135594.27796.37.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2003 at 06:06:34PM +0000, Alan Cox wrote:

 > Arghhh I was told Linus accepted it, and my tree indexer found "IPMI" so
 > decided it was present too. (Only the i2c definitions apparently).

Shouldn't cause any problems in 2.4 anyways should it ?
After all, its 'just another driver'.

 > Oh well, it should be in 2.5

Added to the queue of bits from the 2.4 changesets list that I'm
intending to push to Linus soon.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
