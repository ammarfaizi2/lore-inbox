Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265891AbUGTOOP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265891AbUGTOOP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 10:14:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265893AbUGTOOP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 10:14:15 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:29885 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S265891AbUGTOOO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 10:14:14 -0400
From: "R. J. Wysocki" <rjwysocki@sisk.pl>
Organization: SiSK
To: Andi Kleen <ak@muc.de>
Subject: Re: 2.6.8-rc1: Possible SCSI-related problem on dual Opteron w/ NUMA
Date: Tue, 20 Jul 2004 16:23:41 +0200
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200407171826.03709.rjwysocki@sisk.pl> <200407182338.05282.rjwysocki@sisk.pl> <20040720120430.GB72772@muc.de>
In-Reply-To: <20040720120430.GB72772@muc.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200407201623.41660.rjwysocki@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 of July 2004 14:04, Andi Kleen wrote:
> > To clarify: in the above "your patch" means "x86_64-2.6.8rc1-1".  I
> > should have called it by name.  Sorry for the confusion,
>
> Hmm. Do you have CONFIG_IOMMU_DEBUG on or iommu=force set?

No.  Unless iommu=force is by default (I haven't turned it on specifically).

rjw

-- 
Rafael J. Wysocki
[tel. (+48) 605 053 693]
----------------------------
For a successful technology, reality must take precedence over public 
relations, for nature cannot be fooled.
					-- Richard P. Feynman
