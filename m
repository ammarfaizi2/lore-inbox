Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314938AbSE2LXe>; Wed, 29 May 2002 07:23:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314987AbSE2LXd>; Wed, 29 May 2002 07:23:33 -0400
Received: from ns.sysgo.de ([213.68.67.98]:14845 "EHLO dagobert.svc.sysgo.de")
	by vger.kernel.org with ESMTP id <S314938AbSE2LXd>;
	Wed, 29 May 2002 07:23:33 -0400
Message-Id: <200205291123.g4TBN2k16173@dagobert.svc.sysgo.de>
Content-Type: text/plain; charset=US-ASCII
From: Robert Kaiser <rob@sysgo.de>
Reply-To: rkaiser@sysgo.de
Organization: Sysgo RTS GmbH
To: pavel@suse.cz, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Date: Wed, 29 May 2002 13:25:01 +0200
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> isn't really up to it. Right now we are building cathedrals in the same
>> way as a medaeival master mason, by intutition, experience, and testing.
>> We have no more idea than they do if any given edifice will come
>> crashing down (as several large medaeival ones indeed did).

Now, that's a really nice comparison!

> Well, inability to prove cathedral stability did not stop those people
> from building them, and inability to prove stability of Linx does not
> stop people from using it, too.

As for really safety critical stuff, it definitely does. I know from personal 
experience what it takes to certify software for use in aircrafts. Believe 
me, there is no chance that Linux as we know it could ever pass a DO-178B 
certification process. And for software in aircraft, that is a requirement. 
(Mind you, any form of Windoze doesn't stand a chance either). Similar 
regulations apply to other fields (such as medical devices) and it would 
scare me if that wasn't so. Just do a web search for "Therac-25" if you are 
interested in a (sad) story about what can happen if software in a medical 
device goes wrong.


> (I've seen machine for monitoring patients
> build from "not to use in life-support" chips and running linux.)

As long as the machine only *monitors*, that may be possible. If the machine 
were to e.g. administer medication, that would be a totally different story.

Rob

----------------------------------------------------------------
Robert Kaiser                         email: rkaiser@sysgo.de
SYSGO RTS GmbH
Am Pfaffenstein 14                    phone: (49) 6136 9948-762
D-55270 Klein-Winternheim / Germany   fax:   (49) 6136 9948-10
