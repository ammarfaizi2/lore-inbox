Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136371AbREDNQ7>; Fri, 4 May 2001 09:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136370AbREDNQu>; Fri, 4 May 2001 09:16:50 -0400
Received: from ludwig-alpha.unil.ch ([192.42.197.33]:51363 "EHLO
	ludwig-alpha.unil.ch") by vger.kernel.org with ESMTP
	id <S136371AbREDNQf>; Fri, 4 May 2001 09:16:35 -0400
Message-Id: <200105041316.PAA24118@ludwig-alpha.unil.ch>
X-Mailer: exmh version 2.1.1 10/15/1999
To: "Mike Black" <mblack@csihq.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac3, asm problem in asm-i386/rwsem.h using gcc 3.0 CVS 
In-Reply-To: Your message of "Thu, 03 May 2001 12:14:57 EDT."
             <04e601c0d3ec$32ed29c0$e1de11cc@csihq.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 04 May 2001 15:16:23 +0200
From: Christian Iseli <chris@ludwig-alpha.unil.ch>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


mblack@csihq.com said:
> Looks like if you remove the "inline" from the function definition
> this compiles OK. 

Yup, looks like a compiler bug.  I submitted a bug report to GCC-gnats.

Cheers,
					Christian


