Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282373AbRLVUce>; Sat, 22 Dec 2001 15:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282276AbRLVUcY>; Sat, 22 Dec 2001 15:32:24 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:47099 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S282271AbRLVUcL>; Sat, 22 Dec 2001 15:32:11 -0500
Mime-Version: 1.0
Message-Id: <p05101000b84a980dd9e1@[10.0.0.42]>
Date: Sat, 22 Dec 2001 12:32:04 -0800
To: linux-kernel@vger.kernel.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: Configure.help editorial policy
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlich wrote:

>4Mbit bandwidth is usually 4 * 10^3 * 2^10 bits per second.
>20GB harddrive is usually 20 * 10^6 * 2^10 bytes.

A 20 GB hard drive is always 20 * 10^9 bytes.  I'm not sure why so 
many people on the linux-kernel list think otherwise, but the hard 
drive industry is quite consistent in its use of power-of-10 units to 
describe capacity.  See:

http://www.seagate.com/support/kb/disc/bytes.html
   ("all major disc drive manufactures use decimal values when discussing
     storage capacity")

Answer ID 336 in Maxtor's "Knowledge Base"
   ("Hard drives are marketed in terms of decimal (base 10) capacity.
     In decimal notation, one megabyte (MB) is equal to 1,000,000 bytes,
     and one Gigabyte (GB) is equal to 1,000,000,000 bytes.")

Answer ID 68 in Western Digital's "Knowledge Base"
   ("Drive manufacturers have always defined a megabyte as one million
     bytes.")

http://www.storage.ibm.com/hdd/support/hddfaqs.htm#11

-- 
Tim Seufert
