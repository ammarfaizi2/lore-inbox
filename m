Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbVEMPFj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbVEMPFj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 11:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbVEMPFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 11:05:39 -0400
Received: from smtp105.mail.sc5.yahoo.com ([66.163.169.225]:64445 "HELO
	smtp105.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262401AbVEMPE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 11:04:29 -0400
Subject: Re: several messages
From: Dmitry Yusupov <dmitry_yus@yahoo.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: mingz@ele.uri.edu, Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
       Vladislav Bolkhovitin <vst@vlnb.net>,
       iet-dev <iscsitarget-devel@lists.sourceforge.net>,
       linux-scsi <linux-scsi@vger.kernel.org>, Sander <sander@humilis.net>,
       David Hollis <dhollis@davehollis.com>,
       Maciej Soltysiak <solt2@dns.toxicfilms.tv>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20050513081230.GA32546@infradead.org>
References: <1416215015.20050504193114@dns.toxicfilms.tv>
	 <1115236116.7761.19.camel@dhollis-lnx.sunera.com>
	 <1104082357.20050504231722@dns.toxicfilms.tv>
	 <1115305794.3071.5.camel@dhollis-lnx.sunera.com>
	 <20050507150538.GA800@favonius>
	 <Pine.LNX.4.60.0505102352430.9008@poirot.grange> <4281C8A3.20804@vlnb.net>
	 <Pine.LNX.4.60.0505112309430.8122@poirot.grange>
	 <1115864176.5513.37.camel@localhost.localdomain>
	 <1115922732.25161.143.camel@beastie> <20050513081230.GA32546@infradead.org>
Content-Type: text/plain
Date: Fri, 13 May 2005 08:04:16 -0700
Message-Id: <1115996656.14477.34.camel@mylaptop>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-05-13 at 09:12 +0100, Christoph Hellwig wrote:
> On Thu, May 12, 2005 at 11:32:12AM -0700, Dmitry Yusupov wrote:
> > On Wed, 2005-05-11 at 22:16 -0400, Ming Zhang wrote:
> > > iscsi is scsi over ip.
> > 
> > correction. iSCSI today has RFC at least for two transports - TCP/IP and
> > iSER/RDMA(in finalized progress) with RDMA over Infiniband or RNIC. And
> > I think people start writing initial draft for SCTP/IP transport...
> > 
> > >From this perspective, iSCSI certainly more advanced and matured
> > comparing to NBD variations. 
> 
> It's for certainly much more complicated (in marketing speak that's usually
> called advanced) but far less mature.
> 
> If you want network storage to just work use nbd.

You could tell this to school's computer class teacher... Serious SAN
deployment will always be based either on FC or iSCSI for the reasons I
explained before.

I do not disagree, nbd is nice and simple and for sure has its own
deployment space.

Dmitry

