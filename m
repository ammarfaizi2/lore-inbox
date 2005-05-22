Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261807AbVEVNye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261807AbVEVNye (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 09:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbVEVNye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 09:54:34 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:50602 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261808AbVEVNy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 09:54:28 -0400
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: =?ISO-8859-1?Q?Gr=E9goire?= Favre <gregoire.favre@gmail.com>
Cc: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050521232220.GD28654@gmail.com>
References: <20050516085832.GA9558@gmail.com>
	 <20050517071307.GA4794@in.ibm.com> <20050517002908.005a9ba7.akpm@osdl.org>
	 <1116340465.4989.2.camel@mulgrave> <20050517170824.GA3931@in.ibm.com>
	 <1116354894.4989.42.camel@mulgrave> <20050517192636.GB9121@gmail.com>
	 <1116359432.4989.48.camel@mulgrave> <20050517195650.GC9121@gmail.com>
	 <1116363971.4989.51.camel@mulgrave>  <20050521232220.GD28654@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sun, 22 May 2005 08:54:00 -0500
Message-Id: <1116770040.5002.13.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-05-22 at 01:22 +0200, Grégoire Favre wrote:
> I have found a way to fetch the console :-)
> 
> Against which kernel revision is your patch made for ?

It should work against any recent kernel with the scsi patches.

James


