Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbSLYPPS>; Wed, 25 Dec 2002 10:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262210AbSLYPPS>; Wed, 25 Dec 2002 10:15:18 -0500
Received: from [203.117.131.12] ([203.117.131.12]:45025 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S262190AbSLYPPS>; Wed, 25 Dec 2002 10:15:18 -0500
Message-ID: <3E09CD6D.5020509@metaparadigm.com>
Date: Wed, 25 Dec 2002 23:23:25 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021210 Debian/1.2.1-3
MIME-Version: 1.0
To: Gerhard Mack <gmack@innerfire.net>
Cc: David Lloyd <lloy0076@adam.com.au>,
       Justin Cormack <justin@street-vision.com>, linux-kernel@vger.kernel.org
Subject: Re: OT: Which Gigabit ethernet card?
References: <Pine.LNX.4.44.0212250847230.18327-100000@innerfire.net>
In-Reply-To: <Pine.LNX.4.44.0212250847230.18327-100000@innerfire.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/25/02 21:50, Gerhard Mack wrote:
> On Wed, 25 Dec 2002, David Lloyd wrote:
> 
> 
>>Thank Goodness -- I've worked in places where they INSIST on making
>>crossover cables the same length and colour as normal cables. Then you
>>go, "huh? samba/the network/the kernel" is not working until someone
>>with better eyesight finds the problem.
>>
>>*death to crossover cables*
> 
> 
> That's pretty lame of them but shouldn't the ethernet link light be a good
> indicator that it's a cable problem?
> 
> fix: Dud cable->trash bin "oops was that a crossover? it wasn't marked as
> one."

Or take a two second look holding both RJ45 connectors next to each other
connector side up. If the colours are in the same order on both - it's
straight through. First and third are swapped - it's a crossover cable.

Once you learn this simple trick, you'll never have a problem again -
just get used to spending the extra two seconds before using the cable.

~mc

