Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285327AbRLSPc4>; Wed, 19 Dec 2001 10:32:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285326AbRLSPcq>; Wed, 19 Dec 2001 10:32:46 -0500
Received: from bigspace.hitnet.RWTH-Aachen.DE ([137.226.181.2]:38948 "EHLO
	bigspace.hitnet.rwth-aachen.de") by vger.kernel.org with ESMTP
	id <S285328AbRLSPcj>; Wed, 19 Dec 2001 10:32:39 -0500
Date: Wed, 19 Dec 2001 16:32:34 +0100
From: Thomas Deselaers <thomas@deselaers.de>
To: linux-kernel@vger.kernel.org
Subject: IDE Harddrive Performance
Message-ID: <20011219153233.GA3424@leukertje.hitnet.rwth-aachen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I do have an Asus P2B-S Mainboard and since a week I have a Maxtor 60 GB
5400 rpm Harddrive (MAXTOR 4K060H3).

I tried the performance of the drive and got some results which are quite
low I think.

hdparm -t /dev/hdc returns

/dev/hdc:
 Timing buffered disk reads:  64 MB in  5.63 seconds = 11.37 MB/sec
 
What would be a value I can expect from my hardware? And what might result
in higher speeds?

thanks,
thomas
-- 
thomas@deselaers.de «<>» JabberID on request «<>» GPG/PGP key on request
  «< Unless stated otherwise everything I write is just my opinion >»
