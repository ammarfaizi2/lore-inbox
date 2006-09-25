Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751540AbWIYWUn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbWIYWUn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 18:20:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751539AbWIYWUn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 18:20:43 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:14804 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751529AbWIYWU0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 18:20:26 -0400
Message-ID: <45185625.4050906@pobox.com>
Date: Mon, 25 Sep 2006 18:20:21 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
CC: Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: NV SATA breakage: jgarzik/libata-dev#upstream etc
References: <m3wt7tm6sh.fsf@defiant.localdomain> <451721F8.4060600@pobox.com>	<m3vencjeit.fsf@defiant.localdomain> <m364fbrhow.fsf@defiant.localdomain>
In-Reply-To: <m364fbrhow.fsf@defiant.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> 	ppi[0] = ppi[1] = &nv_port_info[ent->driver_data];

That's probably the best solution.

	Jeff


