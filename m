Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277731AbRJIO4H>; Tue, 9 Oct 2001 10:56:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277749AbRJIO4C>; Tue, 9 Oct 2001 10:56:02 -0400
Received: from wiprom2mx1.wipro.com ([203.197.164.41]:17538 "EHLO
	wiprom2mx1.wipro.com") by vger.kernel.org with ESMTP
	id <S277731AbRJIOzc>; Tue, 9 Oct 2001 10:55:32 -0400
Message-ID: <3BC31014.8010709@wipro.com>
Date: Tue, 09 Oct 2001 20:26:20 +0530
From: "BALBIR SINGH" <balbir.singh@wipro.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20010913
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: pre6 VM issues
In-Reply-To: <Pine.LNX.4.21.0110091057470.5604-100000@freak.distro.conectiva> <3BC30B9F.9060609@wipro.com> <20011009164417.G15943@athlon.random>
Content-Type: multipart/mixed;
	boundary="------------InterScan_NT_MIME_Boundary"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.

--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrea Arcangeli wrote:

>On Tue, Oct 09, 2001 at 08:07:19PM +0530, BALBIR SINGH wrote:
>
>>their pages can even be swapped out if needed. But for a device that is not willing
>>to wait (GFP_ATOMIC) say in an interrupt context, this might be a issue.
>>
>
>There's just a reserved pool for atomic allocations. See the __GFP_WAIT
>check in __alloc_pages.
>
I apologize for my ignorance on this
Balbir

>
>Andrea
>




--------------InterScan_NT_MIME_Boundary
Content-Type: text/plain;
	name="Wipro_Disclaimer.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Wipro_Disclaimer.txt"

----------------------------------------------------------------------------------------------------------------------
Information transmitted by this E-MAIL is proprietary to Wipro and/or its Customers and
is intended for use only by the individual or entity to which it is
addressed, and may contain information that is privileged, confidential or
exempt from disclosure under applicable law. If you are not the intended
recipient or it appears that this mail has been forwarded to you without
proper authority, you are notified that any use or dissemination of this
information in any manner is strictly prohibited. In such cases, please
notify us immediately at mailto:mailadmin@wipro.com and delete this mail
from your records.
----------------------------------------------------------------------------------------------------------------------


--------------InterScan_NT_MIME_Boundary--
