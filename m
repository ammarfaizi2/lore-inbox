Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263189AbTLDIRj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 03:17:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263228AbTLDIRi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 03:17:38 -0500
Received: from adsl.hlfl.org ([81.57.24.20]:64128 "EHLO citron.launay.org")
	by vger.kernel.org with ESMTP id S263172AbTLDIRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 03:17:35 -0500
Date: Thu, 4 Dec 2003 09:17:32 +0100
From: Arnaud Launay <asl@launay.org>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Serial ATA (SATA) for Linux status report
Message-ID: <20031204081732.GC5376@launay.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org
References: <20031203204445.GA26987@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031203204445.GA26987@gtf.org>
User-Agent: Mutt/1.4.1i
X-PGP-Key: http://launay.org/pgpkey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le Wed, Dec 03, 2003 at 03:44:46PM -0500, Jeff Garzik a écrit:
> Intel ICH5
> ----------
> Summary:  No TCQ.  Looks like a PATA controller, but with a few
> added, non-standard SATA port controls.

No plan to add the so-called "raid" capabilities of the 82801EB ?

> Silicon Image 3112

Same here, is support for the 3114 underway ? Saw a message from
Andre Hedrick back in July saying he had something seemingly
working, but there's no news since...

(Andre, no rant here, just a question. It's for personal use and
I'm grateful you do that on your freetime).

	Arnaud.
