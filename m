Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131654AbRDFOFH>; Fri, 6 Apr 2001 10:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131643AbRDFOE5>; Fri, 6 Apr 2001 10:04:57 -0400
Received: from ncc1701.cistron.net ([195.64.68.38]:57863 "EHLO
	ncc1701.cistron.net") by vger.kernel.org with ESMTP
	id <S131627AbRDFOEm>; Fri, 6 Apr 2001 10:04:42 -0400
From: wichert@cistron.nl (Wichert Akkerman)
Subject: Re: syslog insmod please!
Date: 6 Apr 2001 16:03:50 +0200
Organization: Cistron Internet Services
Message-ID: <9akic6$v0c$1@picard.cistron.nl>
In-Reply-To: <Pine.LNX.4.30.0104052147060.14947-100000@age.cs.columbia.edu> <Pine.LNX.4.32.0104060429500.17426-100000@filesrv1.baby-dragons.com>
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.32.0104060429500.17426-100000@filesrv1.baby-dragons.com>,
Mr. James W. Laferriere <babydr@baby-dragons.com> wrote:
>	Not the problem being discussed ,  This is a user now root &
>	having gained root is now attempting to from the command line
>	to load a module .  How do we get this event recorded ?

Recent versions of modutils (2.4.3 and later iirc) log that info
in /var/log/ksymoops

Wichert.


-- 
   ________________________________________________________________
 / Generally uninteresting signature - ignore at your convenience  \
| wichert@cistron.nl                  http://www.liacs.nl/~wichert/ |
| 1024D/2FA3BC2D 576E 100B 518D 2F16 36B0  2805 3CB8 9250 2FA3 BC2D |

