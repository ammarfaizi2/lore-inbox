Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263337AbTD0DT7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 23:19:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263343AbTD0DT7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 23:19:59 -0400
Received: from holomorphy.com ([66.224.33.161]:41148 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263337AbTD0DT6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 23:19:58 -0400
Date: Sat, 26 Apr 2003 20:32:06 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Alternative patching for prefetches & cleanup
Message-ID: <20030427033206.GX8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Linus Torvalds <torvalds@transmeta.com>, Andi Kleen <ak@muc.de>,
	linux-kernel@vger.kernel.org
References: <20030427051451.43064@colin.muc.de> <Pine.LNX.4.44.0304262021190.25498-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0304262021190.25498-100000@home.transmeta.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 27 Apr 2003, Andi Kleen wrote:
>> Hmm. I thought using the Fibonaci sequence for this was clever :-)

On Sat, Apr 26, 2003 at 08:22:58PM -0700, Linus Torvalds wrote:
> That's not the fibonacci sequence, that's just a regular sigma(i)  
> (i=1..n) sequence. And if you were to generate the sequence numbers at
> compile-time I might agree with you, if you also were to avoid using 
> inline asms.

Such things may be checked with:

http://www.research.att.com/~njas/sequences/index.html


-- wli
