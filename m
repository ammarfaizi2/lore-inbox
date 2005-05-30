Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbVE3PDY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbVE3PDY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 May 2005 11:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261642AbVE3PAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 May 2005 11:00:43 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:9691 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261643AbVE3O7h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 May 2005 10:59:37 -0400
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: =?ISO-8859-1?Q?Gr=E9goire?= Favre <gregoire.favre@gmail.com>,
       dino@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <429B2880.7060608@tls.msk.ru>
References: <20050517192636.GB9121@gmail.com>
	 <1116359432.4989.48.camel@mulgrave> <20050517195650.GC9121@gmail.com>
	 <1116363971.4989.51.camel@mulgrave> <20050521232220.GD28654@gmail.com>
	 <1116770040.5002.13.camel@mulgrave> <20050524153930.GA10911@gmail.com>
	 <1117113563.4967.17.camel@mulgrave> <20050526143516.GA9593@gmail.com>
	 <1117118766.4967.22.camel@mulgrave>  <20050526173518.GA9132@gmail.com>
	 <1117463938.4913.3.camel@mulgrave>  <429B2880.7060608@tls.msk.ru>
Content-Type: text/plain
Date: Mon, 30 May 2005 09:59:11 -0500
Message-Id: <1117465151.4913.5.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-05-30 at 18:51 +0400, Michael Tokarev wrote:
> Hmm.. Should there be a pair of {}'s somewhere?

Only if it were actual code for the tree, rather than a throw away
test ... it's a single lun target, so the condition is always true.

James


