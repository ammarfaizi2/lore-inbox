Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751796AbWB1MiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbWB1MiR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 07:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbWB1MiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 07:38:17 -0500
Received: from kunder.interhost.no ([80.239.54.98]:451 "EHLO
	kunder.interhost.no") by vger.kernel.org with ESMTP
	id S1751796AbWB1MiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 07:38:17 -0500
Message-ID: <44044438.5000309@sannes.org>
Date: Tue, 28 Feb 2006 13:38:16 +0100
From: "=?UTF-8?B?QXNiasO4cm4gU2FubmVz?=" <ace@sannes.org>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: John Richard Moser <nigelenki@comcast.net>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Memory compression (again). . help?
References: <4403A14D.4050303@comcast.net> <4403CAE9.5020007@ums.usu.ru> <44043F8C.7070500@comcast.net>
In-Reply-To: <44043F8C.7070500@comcast.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Richard Moser wrote:
> >>> I'm not quite sure what I'm doing or when I have time, but I'm looking
> >>> into writing in some hooks and a compression routine to manage
> >>> compressed memory.
<snip>
> I'm actually looking to submit to mainline in the end ;P  It'd be a very
> good permenant feature.  RAM is cheap, but CPU is even cheaper; if I buy
> a gig of RAM and get 200M free, woohoo?

Nitin Gupta and myself has already started working on a implementation
for 2.6, you are of course welcome to join our effort. Nitin has already
made some code available where you can clearly see where such things
could be done. I can recommend "Understanding the Linux kernel (3rd
Edition)" by Daniel P. Bovet & Marco Cesati. Also, you could take a look
at http://www.kernelnewbies.org/ under recommended books.


Mvh,
Asbjørn Sannes

