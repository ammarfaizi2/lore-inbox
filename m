Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263785AbTLOQEA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 11:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263786AbTLOQEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 11:04:00 -0500
Received: from pix-525-pool.redhat.com ([66.187.233.200]:4301 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263785AbTLOQD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 11:03:57 -0500
Date: Mon, 15 Dec 2003 17:03:17 +0100
From: Arjan van de Ven <arjanv@redhat.com>
To: ataraid-list@redhat.com
Cc: azarah@nosferatu.za.org,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
Subject: Re: Announce: "iswraid" (ICH5R) ataraid sub-driver for 2.4.22
Message-ID: <20031215160317.GF23381@devserv.devel.redhat.com>
References: <933D2981B35C9B4B8793B56C4AE9E16B59396E@azsmsx405.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <933D2981B35C9B4B8793B56C4AE9E16B59396E@azsmsx405.ch.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 15, 2003 at 08:44:31AM -0700, Kannanthanam, Boji T wrote:
> 
> 
> > -----Original Message-----
> > From: Martin Schlemmer [mailto:azarah@nosferatu.za.org] 
> > Sent: Sunday, December 14, 2003 8:49 AM
> > To: Kannanthanam, Boji T
> > 
> > On Tue, 2003-11-25 at 03:15, Kannanthanam, Boji T wrote:
> > > All:
> > > 
> > > Attached to this email is a patch for a new ataraid 
> > sub-driver "iswraid"
> > > (Intel Software RAID) for Kernel 2.4 series. The patch is 
> > taken against
> > > Kernel 2.4.22. 
> > > 
> > 
> > Any time soon this will be available for 2.6 ?
> > 
> 
> Depends on when the ataraid subsystem gets ported to 2.6.

In 2.6 it'll be using device mapper fwiw
