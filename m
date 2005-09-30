Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030395AbVI3Uq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030395AbVI3Uq7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 16:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030389AbVI3Uq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 16:46:59 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:56263 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1030391AbVI3Uq6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 16:46:58 -0400
Subject: Re: I request inclusion of SAS Transport Layer and AIC-94xx into
	the kernel
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Luben Tuikov <luben_tuikov@adaptec.com>
Cc: Andre Hedrick <andre@linux-ide.org>,
       "David S. Miller" <davem@davemloft.net>,
       Jeff Garzik <jgarzik@pobox.com>, willy@w.ods.org,
       Patrick Mansfield <patmans@us.ibm.com>, ltuikov@yahoo.com,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <433D8542.1010601@adaptec.com>
References: <Pine.LNX.4.10.10509300015100.27623-100000@master.linux-ide.org>
	 <433D8542.1010601@adaptec.com>
Content-Type: text/plain
Date: Fri, 30 Sep 2005 15:45:58 -0500
Message-Id: <1128113158.12267.29.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-09-30 at 14:34 -0400, Luben Tuikov wrote:
> James, Linus, can we have this driver in the kernel now, please?

A while ago I told you that if you could show that the transport class
abstraction could not support both the aic94xx and LSI SAS cards then we
could look at doing SAS differently.  Since then you have asserted many
times that a transport class could not work for the aic94xx (mostly by
making inaccurate statements about what the transport class abstraction
is) but have never actually provided any evidence for your assertion.

In a recent prior email, you said:

> Now to things more pertinent, which I'm sure people are interested in:
> 
> Jeff has been appointed to the role of integrating the SAS code
> with the Linux SCSI _model_, with James Bottomley's "transport
> attributes".
> So you can expect more patches from him.

So very soon now, with proof by code, we shall have confirmation or
negation of that assertion.  I'll wait quietly for this to happen, and I
would suggest you do the same.

James


