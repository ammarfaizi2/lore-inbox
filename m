Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263469AbTC2Vbm>; Sat, 29 Mar 2003 16:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263470AbTC2Vbl>; Sat, 29 Mar 2003 16:31:41 -0500
Received: from gate.in-addr.de ([212.8.193.158]:46525 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id <S263469AbTC2Vbh>;
	Sat, 29 Mar 2003 16:31:37 -0500
Date: Sat, 29 Mar 2003 22:41:31 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: war <war@lucidpixels.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.20 Raid Bug?
Message-ID: <20030329214131.GC2755@marowsky-bree.de>
References: <Pine.LNX.4.51.0303291603230.2530@p300>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.51.0303291603230.2530@p300>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-03-29T16:03:51,
   war <war@lucidpixels.com> said:

>     8 root     18446744073709551615 -20     0    0     0 SW<   0.0  0.0
> 0:00 [mdrecoveryd]
> 
> I guess I'll use LVM.

Thanks for this detailed bug report.

Apparently, that naughty mailing list software apparently has dared to cut out
the "how to reproduce" section, as well as all the other relevant information,
notably exact kernel revision, relevant kernel config settings, compiler used, 
the RAID / md configuration involved etc, all of which you certainly provided.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
SuSE Labs - Research & Development, SuSE Linux AG
  
"If anything can go wrong, it will." "Chance favors the prepared (mind)."
  -- Capt. Edward A. Murphy            -- Louis Pasteur
