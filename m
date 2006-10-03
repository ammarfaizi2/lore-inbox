Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbWJCQhX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbWJCQhX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 12:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWJCQhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 12:37:23 -0400
Received: from 70-91-206-233-BusName-SFBA.hfc.comcastbusiness.net ([70.91.206.233]:4497
	"EHLO saville.com") by vger.kernel.org with ESMTP id S932156AbWJCQhV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 12:37:21 -0400
Message-ID: <452291C3.6070903@saville.com>
Date: Tue, 03 Oct 2006 09:37:23 -0700
From: Wink Saville <wink@saville.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
CC: Matthias Hentges <oe@hentges.net>, linux-kernel@vger.kernel.org
Subject: Re: PCI: BIOS Bug: MCFG area at f0000000 is not E820-reserved with
 2.6.18 kernel
References: <45206777.7020405@saville.com> <1159808447.4652.6.camel@mhcln03>	 <4521E326.2000406@saville.com> <1159882225.2891.525.camel@laptopd505.fenrus.org>
In-Reply-To: <1159882225.2891.525.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> 
> please please remove "quiet"... that removes any kind of useful debug
> output! It also makes you point at the wrong party for blaming hangs
> on ;)
> 

Since using Matthias's .config files as the basis for my .config all 
seems to be well. Tonight I will go back and reenable the nvidiafb code 
with "quiet" removed and report my findings.

Thank you,

Wink
