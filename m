Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbTEAGiU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 02:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262689AbTEAGiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 02:38:20 -0400
Received: from CPE-24-163-212-250.mn.rr.com ([24.163.212.250]:19843 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262687AbTEAGiT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 02:38:19 -0400
Subject: Re: must-fix list for 2.6.0
From: Shawn <core@enodev.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@digeo.com>, viro@parcelfarce.linux.theplanet.co.uk,
       ricklind@us.ibm.com, solt@dns.toxicfilms.tv,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       frankeh@us.ibm.com
In-Reply-To: <20030501072703.A3705@infradead.org>
References: <20030430121105.454daee1.akpm@digeo.com>
	 <200304302311.h3UNB2H27134@owlet.beaverton.ibm.com>
	 <20030430162108.09dbd019.akpm@digeo.com>
	 <20030430234746.GW10374@parcelfarce.linux.theplanet.co.uk>
	 <20030430165914.2facc464.akpm@digeo.com>
	 <20030501072703.A3705@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1051768196.5573.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.3.2.99 (Preview Release)
Date: 01 May 2003 01:49:56 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a very useful conversation for the OO guys themselves to hear
about. Anyone care to make them aware of the will of the kernel gods?

On Thu, 2003-05-01 at 02:27, Christoph Hellwig wrote:
> On Wed, Apr 30, 2003 at 04:59:14PM -0700, Andrew Morton wrote:
> > I think it's happening down inside the old linuxthreads library.  No idea
> > who, what, where or why.
> 
> No, they're doing it themselves.  The RedHat OO package has a patch to
> fix this mess (and two dozend other patches to work around OO braindamage..)

