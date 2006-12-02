Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424446AbWLBWCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424446AbWLBWCr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 17:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424453AbWLBWCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 17:02:46 -0500
Received: from astro.systems.pipex.net ([62.241.163.6]:42115 "EHLO
	astro.systems.pipex.net") by vger.kernel.org with ESMTP
	id S1424446AbWLBWCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 17:02:46 -0500
Date: Sat, 2 Dec 2006 22:02:57 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@ginsburg.homenet
To: Adrian Bunk <bunk@stusta.de>
cc: Arjan van de Ven <arjan@infradead.org>, Hua Zhong <hzhong@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] Tigran Aivazian: remove bouncing email addresses
In-Reply-To: <20061202213200.GZ11084@stusta.de>
Message-ID: <Pine.LNX.4.61.0612022201210.1464@ginsburg.homenet>
References: <00e401c7150e$061da500$6721100a@nuitysystems.com>
 <1164964119.3233.56.camel@laptopd505.fenrus.org> <20061201105955.GO11084@stusta.de>
 <Pine.LNX.4.61.0612022101500.1388@ginsburg.homenet> <20061202213200.GZ11084@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Dec 2006, Adrian Bunk wrote:
>> The only bits that should be made sure to remain valid are the
>> MODULE_AUTHOR, as Arjan also mentioned.
>
> Even the "please contact the author" and the printk() should continue to
> contain known bouncing addresses?

Ah, I forgot about that one, but I see Alan Cox already replied and I 
agree with both you and Alan on this.

Kind regards
Tigran
