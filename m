Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280895AbRKYPj2>; Sun, 25 Nov 2001 10:39:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280894AbRKYPjT>; Sun, 25 Nov 2001 10:39:19 -0500
Received: from ncc1701.cistron.net ([195.64.68.38]:18702 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S280892AbRKYPjO>; Sun, 25 Nov 2001 10:39:14 -0500
From: reneb@orac.aais.nl (Rene Blokland)
Subject: Re: PATCH: gcc3.0.2 workaround for 8139too
Date: Sun, 25 Nov 2001 16:37:43 +0100
Organization: Cistron Internet Services B.V.
Message-ID: <slrna02427.3v.reneb@orac.aais.org>
In-Reply-To: <1006394515.14661.0.camel@ulixys> <1006691124.320.0.camel@ulixys>
Reply-To: reneb@cistron.nl
X-Trace: ncc1701.cistron.net 1006702753 25894 62.216.2.136 (25 Nov 2001 15:39:13 GMT)
X-Complaints-To: abuse@cistron.nl
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1006691124.320.0.camel@ulixys>, Ali Akcaagac wrote:
>> so please allow me to post this 'temporarely workaround' here so other
>> people can profit of it until things with the gcc3.0.2 compiler are
>> solved.
Type make &> foo
then the internel error comes
edit foo and remove all the lines until 8139too starts.
remove the rest of the lines and the -O2 in the 8139too line.
cd d*/n*
sh ../../foo
cd /linux
make
There you go!

--
Groeten / Regards, Rene J. Blokland                                 -o)
1073KA 13 2e, the Netherlands                                       /\\
 Paai:     "Windows is als pianospelen met bokshandschoenen aan"   _\_v

