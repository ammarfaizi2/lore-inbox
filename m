Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266326AbRGFJh0>; Fri, 6 Jul 2001 05:37:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266333AbRGFJhQ>; Fri, 6 Jul 2001 05:37:16 -0400
Received: from mail.spylog.com ([194.67.35.220]:36039 "HELO mail.spylog.com")
	by vger.kernel.org with SMTP id <S266326AbRGFJhD>;
	Fri, 6 Jul 2001 05:37:03 -0400
Date: Fri, 6 Jul 2001 13:38:22 +0400
From: Peter Zaitsev <pz@spylog.ru>
X-Mailer: The Bat! (v1.52f)
Reply-To: Peter Zaitsev <pz@spylog.ru>
Organization: SpyLOG
X-Priority: 3 (Normal)
Message-ID: <671559003067.20010706133822@spylog.ru>
To: Nick DeClario <nick@guardiandigital.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re[2]: Is  Swapping on software RAID1 possible  in linux 2.4 ?
In-Reply-To: <3B447FAD.1E4724C9@guardiandigital.com>
In-Reply-To: <1011478953412.20010705152412@spylog.ru>
 <3B447FAD.1E4724C9@guardiandigital.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Nick,

Thursday, July 05, 2001, 6:54:37 PM, you wrote:

Well The idea is simple. I want my system to survive if one of the
disk fails. So I store all of my data including swap on RAID
partitions.


ND> Just out of curiousity what are the advantages to having a RAID1 swap
ND> partition?  Setting the swap priority to 0 (pri=0) in the fstab of all
ND> the swap partitions on your system should have the same effect as doing
ND> it with RAID but without the overhead, right?  RAID1 would also mirror
ND> your swap.  Why would you want that? 

ND> Regards,
ND>         -Nick

ND> Peter Zaitsev wrote:
>> 
>> Hello linux-kernel,
>> 
>>   Does anyone have information on this subject ?  I have the constant
>>   failures with system swapping on RAID1, I just wanted to be shure
>>   this may be the problem or not.   It works without any problems with
>>   2.2 kernel.
>> 
>> --
>> Best regards,
>>  Peter                          mailto:pz@spylog.ru
>> 
>> -
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/




-- 
Best regards,
 Peter                            mailto:pz@spylog.ru

