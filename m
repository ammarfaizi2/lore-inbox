Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264905AbUBROys (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Feb 2004 09:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265757AbUBROys
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Feb 2004 09:54:48 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:10935 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S264905AbUBROyr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Feb 2004 09:54:47 -0500
Message-ID: <40337CB9.50006@stesmi.com>
Date: Wed, 18 Feb 2004 15:54:49 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
CC: Linus Torvalds <torvalds@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel vs AMD x86-64
References: <Pine.LNX.4.58.0402171739020.2686@home.osdl.org> <16435.14044.182718.134404@alkaid.it.uu.se>
In-Reply-To: <16435.14044.182718.134404@alkaid.it.uu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tjena Mikael.

>  >  now that Intel has finally come clean about their x86-64 implementation
>  > (see
>  > 
>  > 	http://www.intel.com/technology/64bitextensions/index.htm?iid=techtrends+spotlight_64bit
>  > 
>  > for full details), can somebody write up a list of differences? I know
>  > there are people who have had access to the Intel docs for a while now,
>  > and obviously Intel is too frigging proud to list the differences
>  > explicitly.
> 
>>From what I can see from these docs, Intel's "IA-32e" is very very close
> to the natural combination of P4 with AMD64. No hyperlink stuff, but
> otherwise the same. The local APIC and performance counters should be
> exactly as in P4 :-)
> 
> What about naming? IA-64 is taken, AMD64 is too specific, Intel's
> "IA-32e" sounds too vague, and I find x86-64 / x86_64 difficult to type.
> "x64" perhaps?

You're not planning on inventing new names for existing technology are
you? That's for the manufacturers to mess up :)

// Stefan

