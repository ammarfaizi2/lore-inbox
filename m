Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751195AbWBRMcl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751195AbWBRMcl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 07:32:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751184AbWBRMcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 07:32:41 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:1260 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751195AbWBRMck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 07:32:40 -0500
Subject: Re: [PATCH 02/22] Firmware interface code for IB device.
From: Arjan van de Ven <arjan@infradead.org>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Christoph Hellwig <hch@infradead.org>, Roland Dreier <rdreier@cisco.com>,
       Greg KH <greg@kroah.com>, Roland Dreier <rolandd@cisco.com>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org, SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com,
       HNGUYEN@de.ibm.com, MEDER@de.ibm.com
In-Reply-To: <20060218122631.GA30535@granada.merseine.nu>
References: <20060218005532.13620.79663.stgit@localhost.localdomain>
	 <20060218005707.13620.20538.stgit@localhost.localdomain>
	 <20060218015808.GB17653@kroah.com> <aday809bewn.fsf@cisco.com>
	 <20060218122011.GE911@infradead.org>
	 <20060218122631.GA30535@granada.merseine.nu>
Content-Type: text/plain
Date: Sat, 18 Feb 2006 13:32:35 +0100
Message-Id: <1140265955.4035.19.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-02-18 at 14:26 +0200, Muli Ben-Yehuda wrote:
> On Sat, Feb 18, 2006 at 12:20:11PM +0000, Christoph Hellwig wrote:
> 
> > > Well, the eHCA guys tell me that they can't post patches to lkml.
> > 
> > Then they lie.  And not posting to lkml is a good reason not to merge
> > an otherwise perfect driver.  (which this one is far from)
> 
> I don't speak for IBM or the authors, but there are perfectly
> reasonable reasons to ask someone else to post a patch on your behalf
> - including but not limited to to only being able to use Lotus Notes
> with one's IBM email. I'm sure you've all seen the travesties that
> Notes inflicts on inline patches.

there are ways around that with webmail etc.

The bigger issue is: if people can't be bothered to do those steps, why
would they be bothered to do this for maintenance and bugfixes etc etc?
Basically it's now already a de-facto unmaintained driver....


