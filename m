Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263675AbTKRPgA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 10:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263679AbTKRPgA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 10:36:00 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:4528 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S263675AbTKRPf7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 10:35:59 -0500
Date: Tue, 18 Nov 2003 07:35:40 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andi Kleen <ak@suse.de>, Herbert Xu <herbert@gondor.apana.org.au>
cc: linux-kernel@vger.kernel.org
Subject: Re: [i386] Remove bogus panic calls in mpparse.c
Message-ID: <4320000.1069169738@[10.10.2.4]>
In-Reply-To: <p738ymksf83.fsf@oldwotan.suse.de>
References: <20031113095721.GB27003@gondor.apana.org.au.suse.lists.linux.kernel> <p738ymksf83.fsf@oldwotan.suse.de>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 2. The user won't see it since the console hasn't initialised yet.
> 
> It just means we should really support early_console on i386 too.
> 
> I believe Martin Bligh has a patch in his -mjb patchkit. I still believe
> it would be very useful in mainline.

Merging has been refused on the grounds of ugliness. However, it does
have the distinct advantage of (a) working and (b) doing something useful.

M.

