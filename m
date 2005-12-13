Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932542AbVLMIVa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932542AbVLMIVa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 03:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932543AbVLMIVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 03:21:30 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:23175 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932542AbVLMIV3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 03:21:29 -0500
Message-ID: <439E8565.3000900@aitel.hist.no>
Date: Tue, 13 Dec 2005 09:25:09 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Salyzyn, Mark" <mark_salyzyn@adaptec.com>
CC: Andrea Arcangeli <andrea@cpushare.com>,
       Arjan van de Ven <arjan@infradead.org>,
       "Randy.Dunlap" <rdunlap@xenotime.net>, Rik van Riel <riel@redhat.com>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
References: <547AF3BD0F3F0B4CBDC379BAC7E4189F01EE9BB3@otce2k03.adaptec.com>
In-Reply-To: <547AF3BD0F3F0B4CBDC379BAC7E4189F01EE9BB3@otce2k03.adaptec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Salyzyn, Mark wrote:

>For instance, there are reasons, somewhat outside the control of the
>Hardware Vendor, for binary drivers. Often, in the hopes of achieving
>standards compliance, Hardware vendors are cornered by legalities over
>the copyright associated with those standards that ties their hands
>either from releasing interface documentation or from releasing source
>code. Yet all these vendors would be overjoyed to have Linux drivers for
>their Hardware in order to increase the sales of their products.
>  
>
Uh, a copyrighted standard?  They are trying to live up to a secret
standard, one they cannot publish?
Don't sound like a standard to me - a standard is something known,
that is the purpose of standardization.
This sounds like "we standardized the voltage for household lamps, but
we won't tell if it is 110V, 220V or something completely different."
I really hope I misunderstood this.

Standards compliance should never get in the way of open source.
Sure - if the owner modifies the source, then the thing may no longer
comply with the standard.  In some cases even illegal or dangerous. 
But in that case, it is the fault of the owner, not the vendor. The vendor
can simply say that anyone changing the (distributed) source should get
their own certification.

Helge Hafting
