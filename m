Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUHEDsO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUHEDsO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Aug 2004 23:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265215AbUHEDsO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Aug 2004 23:48:14 -0400
Received: from fw.osdl.org ([65.172.181.6]:30848 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261375AbUHEDsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Aug 2004 23:48:13 -0400
Date: Wed, 4 Aug 2004 20:46:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Message-Id: <20040804204640.64cd65fc.akpm@osdl.org>
In-Reply-To: <200408042216.12215.gene.heskett@verizon.net>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org>
	<200408042216.12215.gene.heskett@verizon.net>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gene Heskett <gene.heskett@verizon.net> wrote:
>
> On Monday 02 August 2004 09:14, Brett Charbeneau wrote:
>  >Greetings,
>  >
>  >	I am getting the oops below - twice since 7/26, but I haven't a
>  >clue what's causing it.
>  >	I am not a subscriber, so any replies directed to me would be
>  >gratefully received.
>  >	Thank you for your hard work on this!
> 
>  The attachment this gentleman included specifically points to 
>  prune_dcache().  Thats nice.  It also means I'm not alone.  See the 
>  'prune_dcache() Oops, the saga continues' thread.

Except he's running a 2.4 kernel.

Is there any reason why I'm wrong in thinking that you have dodgy
hardware?
