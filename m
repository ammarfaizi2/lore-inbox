Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278025AbRJOFCt>; Mon, 15 Oct 2001 01:02:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278027AbRJOFCk>; Mon, 15 Oct 2001 01:02:40 -0400
Received: from mailgate5.cinetic.de ([217.72.192.165]:34211 "EHLO
	mailgate5.cinetic.de") by vger.kernel.org with ESMTP
	id <S278025AbRJOFC2>; Mon, 15 Oct 2001 01:02:28 -0400
Date: Mon, 15 Oct 2001 07:07:16 +0200 (CEST)
From: Pascal Schmidt <pleasure.and.pain@web.de>
To: Andi Kleen <ak@muc.de>
cc: Tommy Faasen <tommy@vuurwerk.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: SMP processor rework help needed
In-Reply-To: <k2wv1yhsh4.fsf@zero.aec.at>
Message-ID: <Pine.LNX.4.33.0110150706250.1463-100000@neptune.sol.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Oct 2001, Andi Kleen wrote:

> I used to have such an AMP machine too: a dual PII-300 with one Katmai and
> one Deschutes. It's technically a violation of the specs; the Intel SMP
> spec requires that the non boot cpus need to have a superset of the
> features of the boot CPU. One CPU died, so it is symmetric now.
Errrrm, excuse me, but why not simply swap the two CPUs so that the one
with less features becomes the boot CPU?

-- 
Ciao, Pascal

-<[ pharao90@tzi.de, netmail 2:241/215.72, home http://cobol.cjb.net/) ]>-

