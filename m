Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262422AbTEVAuH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 20:50:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262423AbTEVAuH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 20:50:07 -0400
Received: from pop.gmx.de ([213.165.64.20]:2032 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262422AbTEVAuG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 20:50:06 -0400
Message-ID: <3ECC21C9.5000708@gmx.net>
Date: Thu, 22 May 2003 03:03:05 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Andrew Morton <akpm@digeo.com>
CC: linux-kernel@vger.kernel.org, oxymoron@waste.org
Subject: Re: must-fix list, v5
References: <20030521152255.4aa32fba.akpm@digeo.com>
In-Reply-To: <20030521152255.4aa32fba.akpm@digeo.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Also at ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/must-fix/
> 
> For verson 6 I shall go through the "late features" list and prioritise
> things.
> 
> 
> Changes since v5:

> +o willy: random.c is completely lockfree, and not in a good way.  i had
> +  some patches but nothing got seriously tested.
> +

IIRC, Oliver Xymoron had some patches to clean up RNG support at the
time of 2.5.39. Because things were in flux back then, he decided to
postpone these patches until late in the 2.5 cycle.

Oliver?


Regards,
Carl-Daniel

