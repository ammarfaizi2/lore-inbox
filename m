Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273165AbRIJCiD>; Sun, 9 Sep 2001 22:38:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273166AbRIJChx>; Sun, 9 Sep 2001 22:37:53 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:35077 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S273165AbRIJCht>; Sun, 9 Sep 2001 22:37:49 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: John Ripley <jripley@riohome.com>, linux-kernel@vger.kernel.org
Subject: Re: COW fs (Re: Editing-in-place of a large file)
Date: Mon, 10 Sep 2001 04:43:53 +0200
X-Mailer: KMail [version 1.3.1]
Cc: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <20010902152137.L23180@draal.physics.wisc.edu> <3B9B80E2.C9D5B947@riohome.com> <3B9B9917.DA1CC12F@riohome.com>
In-Reply-To: <3B9B9917.DA1CC12F@riohome.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010910023641Z16066-26183+701@humbolt.nl.linux.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On September 9, 2001 06:30 pm, John Ripley wrote:
> Interesting results for the swap partitions. Probably full of zeros.

It doesn't make a lot of sense to spend 30-35% of your swap bandwidth 
swapping zeros in and out, does it?

--
Daniel
