Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263348AbTDCLDQ>; Thu, 3 Apr 2003 06:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263350AbTDCLDQ>; Thu, 3 Apr 2003 06:03:16 -0500
Received: from gate.in-addr.de ([212.8.193.158]:3040 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id <S263348AbTDCLDP>;
	Thu, 3 Apr 2003 06:03:15 -0500
Date: Thu, 3 Apr 2003 13:14:27 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: David Lang <david.lang@digitalinsight.com>,
       "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 64-bit kdev_t - just for playing
Message-ID: <20030403111427.GD13233@marowsky-bree.de>
References: <b6fmoe$nvt$1@cesium.transmeta.com> <Pine.LNX.4.44.0304030207230.31471-100000@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0304030207230.31471-100000@dlang.diginsite.com>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-04-03T02:09:48,
   David Lang <david.lang@digitalinsight.com> said:

> when you think of huge raid arrays that present themselves to the system
> as a single drive even 64 partitions can be limiting.

That's what logical volume management is for. Problem solved.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
SuSE Labs - Research & Development, SuSE Linux AG
  
"If anything can go wrong, it will." "Chance favors the prepared (mind)."
  -- Capt. Edward A. Murphy            -- Louis Pasteur
