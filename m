Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281304AbRKPLZs>; Fri, 16 Nov 2001 06:25:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281313AbRKPLZj>; Fri, 16 Nov 2001 06:25:39 -0500
Received: from [213.151.208.3] ([213.151.208.3]:5898 "EHLO
	imc.intranet.globtel.sk") by vger.kernel.org with ESMTP
	id <S281308AbRKPLZ2>; Fri, 16 Nov 2001 06:25:28 -0500
Subject: Re: ext2/3 performace
From: Robert Varga <nite@hq.alert.sk>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20011116005610.A7077@werewolf.able.es>
In-Reply-To: <20011116005610.A7077@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.0 (Preview Release)
Date: 16 Nov 2001 12:22:20 +0100
Message-Id: <1005909741.2276.5.camel@nitebug.globtel.sk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-11-16 at 00:56, J.A. Magallon wrote:
> /dev/sdb1 (wide at 40):
> ================================================================
> fs=ext2
> read:
> 0.21user 2.97system 1:05.17elapsed 4%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (100major+19minor)pagefaults 0swaps
> ================================================================
> ================================================================
> fs=ext3
> read:
> 0.18user 4.43system 1:05.78elapsed 7%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (100major+19minor)pagefaults 0swaps
> ================================================================

Any idea why system time is up by 49%? Interestingly this doesn't show
up on the U160 disk.

Kind regards,
Robert Varga


