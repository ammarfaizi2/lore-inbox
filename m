Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265136AbUF1TLu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265136AbUF1TLu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 15:11:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265135AbUF1TLt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 15:11:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9900 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265134AbUF1TLc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 15:11:32 -0400
Date: Mon, 28 Jun 2004 20:11:31 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andre Noll <noll@mathematik.tu-darmstadt.de>, linux-kernel@vger.kernel.org
Subject: Re: nfsroot oops 2.6.7-current
Message-ID: <20040628191131.GU12308@parcelfarce.linux.theplanet.co.uk>
References: <slrnce0lrs.tq5.noll@p133.mathematik.tu-darmstadt.de> <1088445193.4394.35.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1088445193.4394.35.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 28, 2004 at 01:53:13PM -0400, Trond Myklebust wrote:
> Yep, and there's probably one missing in fs/nfsctl.c:do_open() too. Al?

ACK
