Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310625AbSCMOsP>; Wed, 13 Mar 2002 09:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310633AbSCMOr5>; Wed, 13 Mar 2002 09:47:57 -0500
Received: from mail.spylog.com ([194.67.35.220]:27851 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S310625AbSCMOrr>;
	Wed, 13 Mar 2002 09:47:47 -0500
Date: Wed, 13 Mar 2002 17:48:14 +0300
From: Peter Zaitsev <pz@spylog.ru>
X-Mailer: The Bat! (v1.53d)
Reply-To: Peter Zaitsev <pz@spylog.ru>
Organization: SpyLOG
X-Priority: 3 (Normal)
Message-ID: <971737727409.20020313174814@spylog.ru>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re[2]: MMAP vs READ/WRITE
In-Reply-To: <Pine.LNX.4.44L.0203131058060.2181-100000@imladris.surriel.com>
In-Reply-To: <Pine.LNX.4.44L.0203131058060.2181-100000@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rik,

Wednesday, March 13, 2002, 4:58:20 PM, you wrote:

Would you like to say me with rmap patches the situation should be
different ?

RvR> On Wed, 13 Mar 2002, Peter Zaitsev wrote:

>>   So I would say mmap is not really optimized nowdays in Linux and so
>>   read() may be wining in cases it should not. May be read-ahead is
>>   used with read and is not used with mmap.

RvR> Both guesses are correct.

RvR> Rik



-- 
Best regards,
 Peter                            mailto:pz@spylog.ru

