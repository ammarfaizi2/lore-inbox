Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268984AbUHZMxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268984AbUHZMxT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 08:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268965AbUHZMxM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 08:53:12 -0400
Received: from nysv.org ([213.157.66.145]:62605 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S268922AbUHZMvB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 08:51:01 -0400
Date: Thu, 26 Aug 2004 15:49:29 +0300
To: Christoph Hellwig <hch@infradead.org>,
       Olivier Galibert <galibert@pobox.com>,
       Christian Mayrhuber <christian.mayrhuber@gmx.net>,
       reiserfs-list@namesys.com, Anton Altaparmakov <aia21@cam.ac.uk>,
       linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826124929.GW1284@nysv.org>
References: <20040824202521.GA26705@lst.de> <20040825163225.4441cfdd.akpm@osdl.org> <1093510983.23289.6.camel@imp.csi.cam.ac.uk> <200408261245.47734.christian.mayrhuber@gmx.net> <20040826115229.A18013@infradead.org> <20040826124334.GA39176@dspnet.fr.eu.org> <20040826134415.A19244@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826134415.A19244@infradead.org>
User-Agent: Mutt/1.5.6i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 01:44:15PM +0100, Christoph Hellwig wrote:
>On Thu, Aug 26, 2004 at 02:43:34PM +0200, Olivier Galibert wrote:
>> He's not proposing to add it to 2.4, is he?
>We're talking about 2.6 here.  2.4 is the obsolete kernel series these days.

So run it in -mm or fork it to 2.7.

2.7 might not be a bad idea for trying such bleeding edge revolution
stuff as this.

-- 
mjt

