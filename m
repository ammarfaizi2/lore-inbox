Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267218AbTAUUf4>; Tue, 21 Jan 2003 15:35:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267219AbTAUUf4>; Tue, 21 Jan 2003 15:35:56 -0500
Received: from smtp08.iddeo.es ([62.81.186.18]:7130 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S267218AbTAUUfz>;
	Tue, 21 Jan 2003 15:35:55 -0500
Date: Tue, 21 Jan 2003 21:44:42 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21pre3aa1
Message-ID: <20030121204442.GA1962@werewolf.able.es>
References: <20030121040628.GD1257@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030121040628.GD1257@dualathlon.random>; from andrea@suse.de on Tue, Jan 21, 2003 at 05:06:28 +0100
X-Mailer: Balsa 2.0.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2003.01.21 Andrea Arcangeli wrote:
> URL:
> 
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21pre3aa1.gz
> 	http://www.us.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.21pre3aa1/
> 
> diff between 2.4.21pre2aa2 and 2.4.21pre3aa1:
> 
[...]
> 
> Only in 2.4.21pre3aa1: 00_one_highpage_init-cleanup-1
> 
> 	Cleanup from J.A. Magallon backported from 2.5.
> 

Credits for that should go to:

 Author: Christoph Hellwig <hch@sgi.com>

who posted it on lkml.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre3-jam2 (gcc 3.2.1 (Mandrake Linux 9.1 3.2.1-2mdk))
