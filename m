Return-Path: <linux-kernel-owner+w=401wt.eu-S1752177AbWLOOKH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752177AbWLOOKH (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 09:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752184AbWLOOKH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 09:10:07 -0500
Received: from smtp-out001.kontent.com ([81.88.40.215]:51166 "EHLO
	smtp-out.kontent.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbWLOOKE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 09:10:04 -0500
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 09:10:04 EST
From: Oliver Neukum <oliver@neukum.org>
To: Krzysztof Halasa <khc@pm.waw.pl>
Subject: Re: [2.6 patch] remove the broken SCSI_SEAGATE driver
Date: Fri, 15 Dec 2006 15:05:27 +0100
User-Agent: KMail/1.8
Cc: Adrian Bunk <bunk@stusta.de>,
       James Bottomley <James.Bottomley@steeleye.com>,
       Andrew Morton <akpm@osdl.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
References: <20061212162238.GR28443@stusta.de> <20061213000902.GD28443@stusta.de> <m3wt4tp9ka.fsf@defiant.localdomain>
In-Reply-To: <m3wt4tp9ka.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612151505.27946.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 15. Dezember 2006 14:34 schrieb Krzysztof Halasa:
> I find it really hard to believe there are still users of things like
> CDU-31A CDs, XT MFM disk controllers, or NCR5380 SCSI host adapters
> (especially the real ones, not DOMEX etc. clones bundled with scanner
> just ~ 10 years ago).

If they do, they probably rarely update their kernel. But not never.

	Regards
		Oliver
