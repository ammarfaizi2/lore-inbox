Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282793AbRLBG7S>; Sun, 2 Dec 2001 01:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282794AbRLBG7I>; Sun, 2 Dec 2001 01:59:08 -0500
Received: from holomorphy.com ([216.36.33.161]:16000 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S282793AbRLBG7C>;
	Sun, 2 Dec 2001 01:59:02 -0500
Date: Sat, 1 Dec 2001 22:59:00 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] tree-based bootmem
Message-ID: <20011201225900.A741@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011117011415.B1180@holomorphy.com> <20011128010411.A14584@figure1.int.wirex.com> <20011128172304.E3921@holomorphy.com> <1007087353.28768.8.camel@phantasy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <1007087353.28768.8.camel@phantasy>; from rml@tech9.net on Thu, Nov 29, 2001 at 09:29:05PM -0500
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-11-28 at 20:23, William Lee Irwin III wrote:
>> This patch has now been successfully tested on 32-bit SPARC.

On Thu, Nov 29, 2001 at 09:29:05PM -0500, Robert Love wrote:
> Add to your list SH4. Successfully patched and booted under kernel
> 2.4.13-pre2 (latest from linux-sh CVS).
> Weee ...


Okay, I've now also got reports of success on sparc64 (notably,
SunBlade 100) and ppc(64?). This is starting to look fairly solid.
A general [CFT] will go out shortly.


Thanks,
Bill
