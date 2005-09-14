Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932530AbVINSqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932530AbVINSqV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 14:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932541AbVINSqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 14:46:21 -0400
Received: from mail.dvmed.net ([216.237.124.58]:25778 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932530AbVINSqU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 14:46:20 -0400
Message-ID: <43286FEF.6020705@pobox.com>
Date: Wed, 14 Sep 2005 14:46:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: Dominik Brodowski <linux@dominikbrodowski.net>,
       linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
       linux-kernel@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>,
       Pantelis Antoniou <panto@intracom.gr>
Subject: Re: [PATCH] MPC8xx PCMCIA driver
References: <20050830024840.GA5381@dmt.cnet> <20050901085319.GB6285@isilmar.linta.de> <20050914141131.GA6830@dmt.cnet> <20050914142746.GA14742@isilmar.linta.de> <20050914182136.GE6783@dmt.cnet>
In-Reply-To: <20050914182136.GE6783@dmt.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> Here is an uptodated version of the MPC8xx PCMCIA driver for v2.6,
> addressing comments by Jeff and Dominik:
> 
> - use IO accessors instead of direct device memory referencing
> - avoid usage of non-standard "uint/uchar" data types
> - kill struct typedef's
> 
> Will submit it for inclusion once v2.6.14 is out. 
> 
> Testing on 8xx platforms is more than welcome! Works like a charm 
> on our custom hardware (CONFIG_PRxK).

No complaints here...

	Jeff



