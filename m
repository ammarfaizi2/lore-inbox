Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284051AbRLAKiN>; Sat, 1 Dec 2001 05:38:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284050AbRLAKiE>; Sat, 1 Dec 2001 05:38:04 -0500
Received: from cpe.atm0-0-0-122182.0x3ef30264.bynxx2.customer.tele.dk ([62.243.2.100]:55682
	"HELO fugmann.dhs.org") by vger.kernel.org with SMTP
	id <S284053AbRLAKhs>; Sat, 1 Dec 2001 05:37:48 -0500
Message-ID: <3C08B2FA.10709@fugmann.dhs.org>
Date: Sat, 01 Dec 2001 11:37:46 +0100
From: Anders Peter Fugmann <afu@fugmann.dhs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Incremental prepatches
In-Reply-To: <3C089BDB.4020801@zytor.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/01/2001 09:59 AM, H. Peter Anvin wrote:

> Hi everyone,
> 
> I have created a robot on kernel.org which makes incremental prepatches 
> available.  It looks for standard-named prepatches in the 
> /pub/linux/kernel/v*.*/testing directories, and creates incrementals in 
> the corresponding /pub/linux/kernel/v*.*/testing/incr directory.
> 

Great.
While you are at it. Could you (when you have the time) extend the 
system to include a patch between the last pre version and a final 
version. Something like:

patch-2.5.1-pre8-2.5.2.gz
(when the time comes :-)

Regards
Anders Fugmann




