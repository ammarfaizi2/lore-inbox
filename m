Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137181AbREKRSx>; Fri, 11 May 2001 13:18:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137182AbREKRSo>; Fri, 11 May 2001 13:18:44 -0400
Received: from Huntington-Beach.blue-labs.org ([208.179.59.198]:64078 "EHLO
	Huntington-Beach.Blue-Labs.org") by vger.kernel.org with ESMTP
	id <S137181AbREKRSZ>; Fri, 11 May 2001 13:18:25 -0400
Message-ID: <3AFC1EC7.7020805@blue-labs.org>
Date: Fri, 11 May 2001 10:17:59 -0700
From: David Ford <david@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.5-pre1 i686; en-US; rv:0.9) Gecko/20010505
X-Accept-Language: en
MIME-Version: 1.0
To: Holger Lubitz <h.lubitz@internet-factory.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: ECN: Volunteers needed
In-Reply-To: <Pine.LNX.4.33.0105091559260.27312-100000@netcore.fi> <Pine.LNX.4.21.0105091249520.23642-100000@scotch.homeip.net> <9dbvh7$amg$1@cesium.transmeta.com> <3AFA8FD7.4B7C14A0@internet-factory.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I simply crontab an ECN off period for five minutes every hour and flush 
the mail queue.

David.

Holger Lubitz wrote:

>"H. Peter Anvin" wrote:
>
>>I suspect that the main way to get this thing fixed is to make sure
>>ECN is enabled on the server side; for example, we have turned on ECN
>>on kernel.org.  If a user is using a broken software stack, it's their
>>loss, not ours.
>>
>
>This is what we do here, too. The only exceptions: Our mail server
>(needs to deliver mail, even to broken sites) and our web proxy server
>(also needs to connect to broken sites sometimes). Everything else is
>ECN enabled. And this is the approach I'd suggest to anybody running 2.4
>servers.
>


