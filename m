Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313675AbSDZGD6>; Fri, 26 Apr 2002 02:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313676AbSDZGD5>; Fri, 26 Apr 2002 02:03:57 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:40439 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S313675AbSDZGD4>; Fri, 26 Apr 2002 02:03:56 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.30.0204251151340.17102-100000@hill.cs.ucr.edu> 
To: John Tyner <jtyner@cs.ucr.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add AM29F040B Support 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 26 Apr 2002 07:03:51 +0100
Message-ID: <14087.1019801031@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


jtyner@cs.ucr.edu said:
> Below is a patch that adds support for the AMD AM29F040B flash chip.
> Hopefully, pine doesn't destory it. 

That chip is already supported in the CVS code. The current plan is to wait 
for 2.4.19 to be released, send the current code to Marcelo for 
2.4.20-pre1, and then look at what broke in 2.5, fix it and send the 
results to Linus.

--
dwmw2


