Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161314AbWHJPKF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161314AbWHJPKF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 11:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161320AbWHJPKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 11:10:05 -0400
Received: from stat9.steeleye.com ([209.192.50.41]:57020 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S1161314AbWHJPKD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 11:10:03 -0400
Subject: RE: [PATCH 1/3] scsi : megaraid_{mm,mbox}: 64-bit DMA
	capabilitychecker
From: James Bottomley <James.Bottomley@SteelEye.com>
To: "Ju, Seokmann" <Seokmann.Ju@lsil.com>
Cc: vvs@sw.ru, akpm@osdl.org, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org,
       "Patro, Sumant" <Sumant.Patro@engenio.com>,
       "Yang, Bo" <Bo.Yang@engenio.com>
In-Reply-To: <890BF3111FB9484E9526987D912B261932E331@NAMAIL3.ad.lsil.com>
References: <890BF3111FB9484E9526987D912B261932E331@NAMAIL3.ad.lsil.com>
Content-Type: text/plain
Date: Thu, 10 Aug 2006 10:09:19 -0500
Message-Id: <1155222559.3670.26.camel@mulgrave.il.steeleye.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-08-10 at 08:55 -0600, Ju, Seokmann wrote:
> Hi,
> Friday, July 28, 2006 2:21 PM, James Bottomley wrote:
> > I'll fix it up this time, but in future could you trailing whitespace
> > check your patches? (git will do this for you).
> I have one clarification.
> When will be these patches merged into scsi-misc tree?
> I've seen them merged into -mm tree.
> I have another patch to create, which tree should I against for it?

This posting:

http://marc.theaimsgroup.com/?l=linux-scsi&m=115509502316547

Should hopefully answer your questions.

James


