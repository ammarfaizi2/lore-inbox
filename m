Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264913AbUGZEk7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264913AbUGZEk7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 00:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUGZEk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 00:40:59 -0400
Received: from lakermmtao07.cox.net ([68.230.240.32]:14046 "EHLO
	lakermmtao07.cox.net") by vger.kernel.org with ESMTP
	id S264913AbUGZEk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 00:40:58 -0400
In-Reply-To: <E1Bow3S-0001qO-00@calista.eckenfels.6bone.ka-ip.net>
References: <E1Bow3S-0001qO-00@calista.eckenfels.6bone.ka-ip.net>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <FC5D956C-DEBD-11D8-9EC8-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: lkml List <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Preliminary Linux Key Infrastructure 0.01-alpha1
Date: Mon, 26 Jul 2004 00:40:57 -0400
To: Bernd Eckenfels <ecki-news2004-05@lina.inka.de>
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 25, 2004, at 23:21, Bernd Eckenfels wrote:
> In article <65EFF013-DEAA-11D8-9612-000393ACC76E@mac.com> you wrote:
>> Preliminary Linux Key Infrastructure 0.01-alpha1:
>
> What kind of keys you want to store and what are they used for?

My code is in followup to the LKML discussion here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=108700802812286&w=2

The goal is simply to put encryption keys in the kernel so they can be
used by a variety of systems, AFS, NFSv4, dm-crypt, CryptoAPI, etc.

There was also a bit of a discussion on OpenAFS-devel about it too.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a17 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


