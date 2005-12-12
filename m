Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbVLKXig@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbVLKXig (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Dec 2005 18:38:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbVLKXig
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Dec 2005 18:38:36 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:23985 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750919AbVLKXie (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Dec 2005 18:38:34 -0500
Subject: Re: RFC: ACPI/scsi/libata integration and hotswap
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>,
       Christoph Hellwig <hch@infradead.org>, randy_d_dunlap@linux.intel.com,
       linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
In-Reply-To: <439A4070.2000500@pobox.com>
References: <20051208145257.GB21946@srcf.ucam.org>
	 <20051208171901.GA22451@srcf.ucam.org>
	 <20051209114246.GB16945@infradead.org>
	 <20051209114944.GA1068@havoc.gtf.org>
	 <20051209115235.GB25771@srcf.ucam.org> <43997171.9060105@pobox.com>
	 <20051209121124.GA25974@srcf.ucam.org> <439975AB.5000902@pobox.com>
	 <20051209122457.GB26070@srcf.ucam.org> <439A23E8.3080407@pobox.com>
	 <20051210023426.GA31220@srcf.ucam.org>  <439A4070.2000500@pobox.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Dec 2005 00:38:28 +0000
Message-Id: <1134347909.2737.10.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-12-09 at 21:41 -0500, Jeff Garzik wrote:
> Do you even know if this special case is applicable outside of Dell ICH5 
> boxes?  And I thought your previous messages were referring to ICH6?

Some older thinkpads seem to support this. Also some laptops generate
pnpbios changes. The different methods alone argue for a generic
interface
h
