Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131164AbRBXCt0>; Fri, 23 Feb 2001 21:49:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131173AbRBXCtQ>; Fri, 23 Feb 2001 21:49:16 -0500
Received: from mail004.syd.optusnet.com.au ([203.2.75.228]:60623 "EHLO
	mail004.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S131166AbRBXCtN>; Fri, 23 Feb 2001 21:49:13 -0500
From: Michal Gornisiewicz <jedin@iname.com>
To: mason@suse.com, linux-kernel@vger.kernel.org
Subject: Re: reiserfs: still problems with tail conversion
Date: Sat, 24 Feb 2001 10:52:07 +0800
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
In-Reply-To: <20010223221856.A24959@arthur.ubicom.tudelft.nl> <730960000.982966246@tiny> <20010223231949.D24959@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010223231949.D24959@arthur.ubicom.tudelft.nl>
MIME-Version: 1.0
Message-Id: <01022410520700.01447@Defiance.Hell>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 24 February 2001 06:19, Erik Mouw wrote:
> I'll upgrade to linux-2.4.2 to see if it solves the problem. (was
> running 2.4.2-pre4 + your patch)
>
>
> Erik

I'm running 2.4.2 and I get similar results using your test program.
This is on an IBM 390 Laptop. P2-233, 96mb RAM, 3.2gb HDD.

See program results below. I can supply more info 
(.config etc, & do testing) if needed.

MG



Creating 8192 files ... done
Appending to the files ... done
Checking files for null bytes ...
  reiser-00107.test contains null bytes
  reiser-00127.test contains null bytes
  reiser-00208.test contains null bytes
  reiser-00234.test contains null bytes
  reiser-00259.test contains null bytes
  reiser-00303.test contains null bytes
  reiser-00324.test contains null bytes
  reiser-00343.test contains null bytes
  reiser-00371.test contains null bytes
  reiser-00388.test contains null bytes
  reiser-00444.test contains null bytes
  reiser-00452.test contains null bytes
  reiser-00459.test contains null bytes
  reiser-00466.test contains null bytes
  reiser-00495.test contains null bytes
  reiser-00502.test contains null bytes
  reiser-00515.test contains null bytes
  reiser-00522.test contains null bytes
  reiser-00535.test contains null bytes
  reiser-00548.test contains null bytes
  reiser-00608.test contains null bytes
  reiser-00614.test contains null bytes
  reiser-00620.test contains null bytes
  reiser-00626.test contains null bytes
  reiser-00637.test contains null bytes
  reiser-00648.test contains null bytes
  reiser-00659.test contains null bytes
  reiser-00669.test contains null bytes
  reiser-00674.test contains null bytes
  reiser-00704.test contains null bytes
  reiser-00744.test contains null bytes
  reiser-00749.test contains null bytes
  reiser-00754.test contains null bytes
  reiser-00759.test contains null bytes
  reiser-00764.test contains null bytes
  reiser-00773.test contains null bytes
  reiser-00778.test contains null bytes
  reiser-00787.test contains null bytes
  reiser-00792.test contains null bytes
  reiser-00801.test contains null bytes
  reiser-00810.test contains null bytes
  reiser-00819.test contains null bytes
  reiser-00847.test contains null bytes
  reiser-00855.test contains null bytes
  reiser-00899.test contains null bytes
  reiser-00947.test contains null bytes
  reiser-00951.test contains null bytes
  reiser-00955.test contains null bytes
  reiser-00959.test contains null bytes
  reiser-00963.test contains null bytes
  reiser-00967.test contains null bytes
  reiser-00971.test contains null bytes
  reiser-00978.test contains null bytes
  reiser-00982.test contains null bytes
  reiser-00986.test contains null bytes
  reiser-00990.test contains null bytes
  reiser-00997.test contains null bytes
  reiser-01001.test contains null bytes
  reiser-01005.test contains null bytes
  reiser-01012.test contains null bytes
  reiser-01016.test contains null bytes
Checking done
