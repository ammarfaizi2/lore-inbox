Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267875AbRGRNKc>; Wed, 18 Jul 2001 09:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267873AbRGRNKW>; Wed, 18 Jul 2001 09:10:22 -0400
Received: from co3000407-a.belrs1.nsw.optushome.com.au ([203.164.252.88]:46720
	"EHLO bozar") by vger.kernel.org with ESMTP id <S267874AbRGRNKQ>;
	Wed, 18 Jul 2001 09:10:16 -0400
Date: Wed, 18 Jul 2001 23:09:43 +1000
From: Andre Pang <ozone@algorithm.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: ReiserFS / 2.4.6 / Data Corruption
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010717211401.A322@caltech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010717211401.A322@caltech.edu>
User-Agent: Mutt/1.3.18i
Message-Id: <995461783.758586.24447.nullmailer@bozar.algorithm.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 17, 2001 at 09:14:01PM -0700, Sam Thompson wrote:

> Tar/gzip will complain about crc errors in files: for example
> in a certain 40 mb file I can decompress fine on other
> computers. If I try to uncompress the same file immediately,
> it will fail at a different point, seemingly at random.
> Sometimes it works fine. Random debian packages I apt-get have
> the same problem. Sometimes they won't unpack properly,
> sometimes they will.

you also possibly have a ram problem.  check out memtest86 at
freshmeat.net and try that.  anything can happen to a computer
if power dies unexpectedly.


-- 
#ozone/algorithm <ozone@algorithm.com.au>          - trust.in.love.to.save
