Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129708AbQLHBj5>; Thu, 7 Dec 2000 20:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129967AbQLHBjs>; Thu, 7 Dec 2000 20:39:48 -0500
Received: from tungsten.btinternet.com ([194.73.73.81]:53426 "EHLO
	tungsten.btinternet.com") by vger.kernel.org with ESMTP
	id <S129708AbQLHBjg>; Thu, 7 Dec 2000 20:39:36 -0500
Date: Fri, 8 Dec 2000 01:08:36 +0000 (GMT)
From: davej@suse.de
To: Eric Estabrooks <estabroo@talkware.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: cyrix III by via
In-Reply-To: <3A3024D4.EDA13485@talkware.net>
Message-ID: <Pine.LNX.4.21.0012080106360.11972-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Eric Estabrooks wrote:

> A test probably needs to be added in the centaur_model section to test
> for the cyrixIII in disguise.

2.2.18pre, and 2.4.0test have contained this test for some time now.
However, I've heard no reports of it working or not due to no-one having
the necessary hardware to test it.

Are you saying the latest versions still don't recognise it?
What kernel version did you try ?

regards,

Davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
