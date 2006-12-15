Return-Path: <linux-kernel-owner+w=401wt.eu-S932413AbWLOAvL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932413AbWLOAvL (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 19:51:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbWLOAvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 19:51:10 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39513 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932281AbWLOAvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 19:51:09 -0500
Date: Fri, 15 Dec 2006 00:59:21 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: Bill Nottingham <notting@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix help text for CONFIG_ATA_PIIX
Message-ID: <20061215005921.1a5d0ef6@localhost.localdomain>
In-Reply-To: <200612142006.49406.s0348365@sms.ed.ac.uk>
References: <200612141714.55948.s0348365@sms.ed.ac.uk>
	<200612141832.50587.s0348365@sms.ed.ac.uk>
	<20061214195314.GC10955@nostromo.devel.redhat.com>
	<200612142006.49406.s0348365@sms.ed.ac.uk>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks for clarifying Bill, and sorry Alan. ata_piix does indeed work 
> correctly. The help text is a bit confusing:

The help text is out of date - thanks that is a real bug 
