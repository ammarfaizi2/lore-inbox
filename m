Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264609AbTFKXVg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 19:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264610AbTFKXVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 19:21:36 -0400
Received: from 216-239-45-4.google.com ([216.239.45.4]:27269 "EHLO
	216-239-45-4.google.com") by vger.kernel.org with ESMTP
	id S264609AbTFKXVe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 19:21:34 -0400
Date: Wed, 11 Jun 2003 16:35:15 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] nfs_unlink() race
Message-ID: <20030611163515.A4174@google.com>
References: <Pine.LNX.4.44.0306110929260.1653-100000@home.transmeta.com> <1055352127.2419.25.camel@dhcp22.swansea.linux.org.uk> <16103.26865.361044.360120@charged.uio.no> <16103.29804.198545.680701@charged.uio.no> <20030611152436.A3241@google.com> <16103.47167.69772.316938@charged.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16103.47167.69772.316938@charged.uio.no>; from trond.myklebust@fys.uio.no on Thu, Jun 12, 2003 at 01:16:15AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 01:16:15AM +0200, Trond Myklebust wrote:
> >>>>> " " == Frank Cusack <fcusack@fcusack.com> writes:
>      > Doesn't the above simply always revalidate?
> 
> That's the whole problem in a nutshell. Read the thread...

Oh, I thought you were fixing an NFS problem with that patch.

/fc
