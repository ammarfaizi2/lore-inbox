Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964849AbWDCSQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964849AbWDCSQw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 14:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWDCSQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 14:16:51 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:10631 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964840AbWDCSQu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 14:16:50 -0400
Date: Mon, 3 Apr 2006 20:16:19 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Jes Sorensen <jes@sgi.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>, bjorn_helgaas@hp.com,
       cotte@de.ibm.com
Subject: Re: [patch] msepc driver (requires do_no_pfn)
In-Reply-To: <yq0fykuuc3h.fsf@jaguar.mkp.net>
Message-ID: <Pine.LNX.4.61.0604032015380.18399@yvahk01.tjqt.qr>
References: <yq0fykuuc3h.fsf@jaguar.mkp.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>+config MSPEC
>+	tristate "  Memory special operations driver"

The two blanks after " are not needed anymore with the new Kconfig 
from 2.6.x.


Jan Engelhardt
-- 
