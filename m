Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264890AbUGBTZs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264890AbUGBTZs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 15:25:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264903AbUGBTZs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 15:25:48 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9099 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264890AbUGBTZq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 15:25:46 -0400
Message-ID: <40E5B6AD.6060904@pobox.com>
Date: Fri, 02 Jul 2004 15:25:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dan Williams <dcbw@redhat.com>
CC: linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: [PATCH] Update in-kernel orinoco drivers to upstream current
 CVS
References: <1088795498.18039.25.camel@dcbw.boston.redhat.com>
In-Reply-To: <1088795498.18039.25.camel@dcbw.boston.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams wrote:
> Hi,
> 
> This patch is simply the fixed-up diff between the kernel's current
> 0.13e version and the upstream 0.15rc1+ version from savannah CVS.
> 0.15rc1 has been out for a couple months now and seems stable.
> 
> The major benefits that this newer version brings are, of course, many
> bugfixes, but best of all wireless scanning support for the Orinoco line
> of cards.
> 
> http://people.redhat.com/dcbw/linux-2.6.7-orinoco.patch.bz2
> 
> Dan Williams
> Red Hat, Inc.


I'm desperately hoping that someone will split this up into multiple 
patches...

	Jeff


