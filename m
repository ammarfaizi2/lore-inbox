Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265255AbUG2U5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265255AbUG2U5s (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 16:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265245AbUG2U5r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 16:57:47 -0400
Received: from Mail.MNSU.EDU ([134.29.1.12]:39634 "EHLO mail.mnsu.edu")
	by vger.kernel.org with ESMTP id S265255AbUG2Uy2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 16:54:28 -0400
Message-ID: <41096401.3040404@mnsu.edu>
Date: Thu, 29 Jul 2004 15:54:25 -0500
From: "Jeffrey E. Hundstad" <jeffrey.hundstad@mnsu.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rogier Wolff <Rogier@wolff.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: OK, anybody have any hints and tips to get an MFM drive working
 again?
References: <20040729201458.GA19252@bitwizard.nl>
In-Reply-To: <20040729201458.GA19252@bitwizard.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use a 2.2 kernel.

Rogier Wolff wrote:

>Hi,
>
>We need to recover some data off an old MFM drive. We've got a bunch
>of those cards, we've got a bunch of drives to experment with, but 
>once we get things working we'll recover some 2x20Mb of data off two
>20Mb drives....
>
>We've tried the modern IDE driver, and the 2.4.20 one, and the "old
>hd only" driver. 
>
>Going "retro": Compiling 2.0.39 gives me: "bus error" while doing 
>make dep. 
>
>I THINK we have a couple of those cards that don't have any 
>interrupts. Would Linux be able to work with those?
>
>Yes, we pass "hda=615,4,17" to the IDE driver. 
>
>Any suggestions of things to try?
>
>		Roger. 
>
>  
>
