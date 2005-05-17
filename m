Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261309AbVEQTvl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261309AbVEQTvl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 15:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261357AbVEQTvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 15:51:41 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:29655 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261309AbVEQTvi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 15:51:38 -0400
Subject: Re: What breaks aic7xxx in post 2.6.12-rc2 ?
From: James Bottomley <James.Bottomley@SteelEye.com>
To: =?ISO-8859-1?Q?Gr=E9goire?= Favre <gregoire.favre@gmail.com>
Cc: dino@in.ibm.com, Andrew Morton <akpm@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
In-Reply-To: <20050517192636.GB9121@gmail.com>
References: <20050516085832.GA9558@gmail.com>
	 <20050517071307.GA4794@in.ibm.com> <20050517002908.005a9ba7.akpm@osdl.org>
	 <1116340465.4989.2.camel@mulgrave> <20050517170824.GA3931@in.ibm.com>
	 <1116354894.4989.42.camel@mulgrave>  <20050517192636.GB9121@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Date: Tue, 17 May 2005 14:50:31 -0500
Message-Id: <1116359432.4989.48.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-05-17 at 21:26 +0200, Grégoire Favre wrote:
> Well, it don't... I send you a private mail with a picture I take a boot
> time.

Right, but the problem I think it will fix is the initial inquiry being
sent with the wrong transport parameters.

You have a different problem, I think ... it looks like your Toshiba DVD
does somthing strange during Domain Validation ... the question I don't
have an answer to yet, is what.

James


