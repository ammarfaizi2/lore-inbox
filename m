Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932320AbWAZOJo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWAZOJo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 09:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932321AbWAZOJo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 09:09:44 -0500
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:4462 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932320AbWAZOJo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 09:09:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=gh1gte0JDk5/bKqwjUDXWy2wo2/utMzdu9ni4F6WqaQbODxJWiquVzz1HaA+QY5lCpcCY46R0PNak03XVVVgUkegrc430Vi582D5Fw200IHOOd1//N+ISip5YhQ9C2kIyhB+pkfx3YzYnkGOz3Vrh8ChokNplc0PXACHgTw7EDQ=  ;
Message-ID: <43D8D80B.9080203@yahoo.com.au>
Date: Fri, 27 Jan 2006 01:09:15 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
CC: rlrevell@joe-job.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, grundig@teleline.es, axboe@suse.de,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
References: <787b0d920601241923k5cde2bfcs75b89360b8313b5b@mail.gmail.com> <Pine.LNX.4.61.0601251523330.31234@yvahk01.tjqt.qr> <20060125144543.GY4212@suse.de> <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr> <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner> <20060125181847.b8ca4ceb.grundig@teleline.es> <43D8988F.nailDTH21LS0G@burner> <1138268759.3087.138.camel@mindpipe> <43D8D5A0.nailE2X71H31H@burner>
In-Reply-To: <43D8D5A0.nailE2X71H31H@burner>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling wrote:
> Lee Revell <rlrevell@joe-job.com> wrote:
> 
> 
>>>Interesting: You claim that the Linux platform provides ways to retrieve 
>>>the needed information on FreeBSD, MS-WIN, ....?
>>>
>>
>>What do FreeBSD and MS-WIN have to do with Linux?
> 
> 
> What is the relevence of /dev/hd* for a device independent library like libscg?
> 

Isn't it good practice to adhere to the naming conventions
of the system to which a program is ported to? (even if 100
of them do it one way and 1 does it another)

I don't claim to be an expert in the area at all, but it seems
like the best way to do it IMHO.

Thanks,
Nick
--
Send instant messages to your online friends http://au.messenger.yahoo.com 
