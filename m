Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269835AbUIDI07@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269835AbUIDI07 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 04:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269836AbUIDI07
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 04:26:59 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:50370 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S269835AbUIDI0u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 04:26:50 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] schedstats additions
Date: Sat, 4 Sep 2004 10:26:51 +0200
User-Agent: KMail/1.6.2
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, Rick Lindsley <ricklind@us.ibm.com>
References: <41394D79.40205@yahoo.com.au>
In-Reply-To: <41394D79.40205@yahoo.com.au>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409041026.51519.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dnia Saturday 04 of September 2004 07:07, Nick Piggin napisa³:
> Hi,
> I have a patch here to provide more useful statistics for me. Basically
> it moves a lot more of the balancing information into the domains instead
> of the runqueue, where it is nearly useless on multi-domain setups (eg.
> SMT+SMP, SMP+NUMA).

Which kernel version it is against?

RJW

-- 
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
