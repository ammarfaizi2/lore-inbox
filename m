Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbUCWG1Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 01:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262077AbUCWG1Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 01:27:25 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:31493 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262063AbUCWG1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 01:27:23 -0500
Date: Tue, 23 Mar 2004 06:27:08 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@debian.org>
Cc: "Bagalkote, Sreenivas" <sreenib@lsil.com>,
       "'Jeff Garzik'" <jgarzik@pobox.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH][RELEASE] megaraid 2.10.2 Driver
Message-ID: <20040323062708.A29405@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <willy@debian.org>,
	"Bagalkote, Sreenivas" <sreenib@lsil.com>,
	'Jeff Garzik' <jgarzik@pobox.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	"'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
References: <0E3FA95632D6D047BA649F95DAB60E570230C77B@exa-atlanta.se.lsil.com> <20040323004543.GP25059@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040323004543.GP25059@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Tue, Mar 23, 2004 at 12:45:43AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2004 at 12:45:43AM +0000, Matthew Wilcox wrote:
> I don't think you understand how CONFIG_COMPAT works.  x86-64 defines it
> when it wants it:

But not in 2.4, and this is a 2.4-only patch..

