Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271780AbRH2BBI>; Tue, 28 Aug 2001 21:01:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271779AbRH2BA7>; Tue, 28 Aug 2001 21:00:59 -0400
Received: from zok.sgi.com ([204.94.215.101]:45978 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id <S271775AbRH2BAo>;
	Tue, 28 Aug 2001 21:00:44 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Andi Kleen <ak@suse.de>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
        bgerst@didntduck.org, haba@pdc.kth.se
Subject: Re: Size of pointers in sys_call_table? 
In-Reply-To: Your message of "28 Aug 2001 18:54:06 +0200."
             <oupd75gjfbl.fsf@pigdrop.muc.suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 29 Aug 2001 11:00:36 +1000
Message-ID: <20334.999046836@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Aug 2001 18:54:06 +0200, 
Andi Kleen <ak@suse.de> wrote:
>[Introducing quiescent states in module unloading would probably fix that,
>as it has been discussed for a long time now, but I lost hope that it'll ever
>get implemented in the main kernel]

It will, in 2.5.

