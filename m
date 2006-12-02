Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424357AbWLBSfk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424357AbWLBSfk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 13:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424365AbWLBSfk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 13:35:40 -0500
Received: from qb-out-0506.google.com ([72.14.204.231]:12196 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1424357AbWLBSfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 13:35:39 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:subject:from:reply-to:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=qff3bm2WFR1JWt+0VNDzarnKcfHG3OJotbMG1WyDaCRw4bB1YD5bDLo9XVkTw/mpgUpikDoPit8LXfgXB9Hn6AEA08LYzfikesKvFLu6JVY/G/henXPu24SJuP2M+XeYjbtqOZcPm/aNc+49RoACBi6IrNlWugNXfGLJUHolGyw=
Subject: Re: [dm-devel] Re: [RFC][PATCH] dm-cache: block level disk cache
	target for device mapper
From: Ming Zhang <blackmagic02881@gmail.com>
Reply-To: blackmagic02881@gmail.com
To: Ming Zhao <mingzhao99th@gmail.com>
Cc: device-mapper development <dm-devel@redhat.com>,
       bert hubert <bert.hubert@netherlabs.nl>, ming@acis.ufl.edu,
       Linux Kernel <linux-kernel@vger.kernel.org>, ericvh@gmail.com
In-Reply-To: <b1e142760612021028t522ba3ffs485bc70d93a85774@mail.gmail.com>
References: <200611271826.kARIQYRi032717@hera.kernel.org>
	 <20061127184748.GA11219@outpost.ds9a.nl>
	 <a4e6962a0611271155q55adf6fftd489de84d6ae7e88@mail.gmail.com>
	 <1165022497.2761.216.camel@localhost.localdomain>
	 <b1e142760612021028t522ba3ffs485bc70d93a85774@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 02 Dec 2006 13:35:36 -0500
Message-Id: <1165084536.5456.9.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 2006-12-02 at 13:28 -0500, Ming Zhao wrote:
> On 12/1/06, Ming Zhang <blackmagic02881@gmail.com> wrote:
> > like to see this idea but any similarity with
> > http://www.ele.uri.edu/Research/hpcl/STICS/stics.pdf?
> >
> > STICS is patent pending so not sure if kernel can be free to merge this
> > dm-cache.
> 
> I like the idea of STICS, an efficient bridge between SCSI and IP. But
> I think its only similarity with dm-cache is the use of nonvolatile
> caching.
> 
> Dm-cache is a generic block-level disk cache that supports a variety
> of SAN technologies and is not tied to any particular one.
> 


great. as long as you are aware of this and can find the difference,
then fine.

> 
> Best regards,
> Ming Zhao

