Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282887AbRK0JIg>; Tue, 27 Nov 2001 04:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282886AbRK0JI1>; Tue, 27 Nov 2001 04:08:27 -0500
Received: from inet-mail4.oracle.com ([148.87.2.204]:65492 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S282887AbRK0JIO>; Tue, 27 Nov 2001 04:08:14 -0500
Message-ID: <3C0357F6.4000300@oracle.com>
Date: Tue, 27 Nov 2001 04:08:06 -0500
From: Svein Erik Brostigen <svein.brostigen@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Allan Sandfeld <linux@sneulv.dk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Release Policy [was: Linux 2.4.16  ]
In-Reply-To: <Pine.LNX.4.40.0111261216500.88-100000@rc.priv.hereintown.net> <20011126161802.A8398@xi.linuxpower.cx> <3C034889.6040000@oracle.com> <E168dbm-0000Jr-00@Princess>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allan Sandfeld wrote:

>On Tuesday 27 November 2001 09:02, Svein Erik Brostigen wrote:
>
>>What really scares me is not so much the way the kernels are numbered as
>>the way features gets added to
>>the kernels.
>>
>The problem is that for kernels new features _are_ bug-fixes. Like the new 
>vm, work-around for discovered bugs in hardware, etc., etc. 
>I an way what should't be done in a -rc release is new fixing features, but 
>only the fixing _of_ features. ;-)
>
Hmmm... workarounds are not new  features, but bug-fixes ;-)
The new vm is not a *new* feature, it is just a different vm than the 
old. Even if you treat it as a new
feature, it should then be incorporated into a new-feature release, i.e 
not in a 2.4.10.4, but maybe in what
would have been a 2.4.11.0.

I'm not going to be anal about this, but a more structured way of 
handling new features/bug-fixes and release
numbering would be nice. A lot easier to know what you are programming 
against and what you are
installing/testing.


-- 
Regards
Svein Erik

I've given up reading books; I find it takes my mind off myself.
_____________________________________________________________
Svein Erik Brostigen       e-mail: svein.brostigen@oracle.com
Senior Technical Analyst                  Phone: 407.458.7168
EBC - Extended Business Critical
Oracle Support Services
5955 T.G. Lee Blvd
Orlando FL, 32822

Enabling the Information Age Through Internet Computing
_____________________________________________________________

The statements and opinions expressed here are my own and
do not necessarily represent those of Oracle Corporation.



