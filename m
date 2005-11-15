Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965091AbVKOX40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965091AbVKOX40 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 18:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965092AbVKOX40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 18:56:26 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:50608 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S965091AbVKOX40 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 18:56:26 -0500
In-Reply-To: <20051116004111.45f3f704.grundig@teleline.es>
References: <20051116004111.45f3f704.grundig@teleline.es>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DCB14CD5-D70E-4CA5-984A-F61DFB104E05@comcast.net>
Cc: Arjan van de Ven <arjan@infradead.org>,
       Bernd Petrovitsch <bernd@firmix.at>,
       linux-kernel <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Parag Warudkar <kernel-stuff@comcast.net>
Subject: Re: [2.6 patch] i386: always use 4k stacks
Date: Tue, 15 Nov 2005 18:56:17 -0500
To: "Wed, 16 Nov 2005 00:41:11 +0100" <grundig@teleline.es>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Nov 15, 2005, at 6:41 PM, Wed, 16 Nov 2005 00:41:11 +0100 wrote:

>
>> documentation for broadcom wireless:
>> http://bcm-specs.sipsolutions.net/
>> embrionic driver based on this spec:
>> http://bcm43xx.berlios.de/
>
>
> Maybe a good deal would be to delay the 4K patch until some  
> preliminary
> version of those is merged?

Andi had some pretty valid comments against the 4K approach.
Here - http://lkml.org/lkml/2005/9/6/4
I didn't see anyone contradicting his opinion. Seems very plausible  
to me.

Parag
