Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275492AbRIZS4m>; Wed, 26 Sep 2001 14:56:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275489AbRIZS4g>; Wed, 26 Sep 2001 14:56:36 -0400
Received: from chiara.elte.hu ([157.181.150.200]:18700 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S275481AbRIZSzg>;
	Wed, 26 Sep 2001 14:55:36 -0400
Date: Wed, 26 Sep 2001 20:53:41 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: James Washer <e2big@us.ibm.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Kernel text getting corrupted 
In-Reply-To: <200109261827.f8QIRlk05044@crg8.beaverton.ibm.com>
Message-ID: <Pine.LNX.4.33.0109262052390.7740-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 26 Sep 2001, James Washer wrote:

> We've got a strange one. We're seeing system crashes where memory,
> including kernel text (executable) pages, is being corrupted. If you
> have any idea what might be causing this, or if you've seen this
> yourself, or if you have ideas on how to debug it, please let us know.
[...]

> Software linux2.4.8, [...]

well, the standard question: does it happen with 2.4.10? there were many
fixes since 2.4.8.

	Ingo

