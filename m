Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752021AbWCNWbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021AbWCNWbQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 17:31:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751947AbWCNWbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 17:31:15 -0500
Received: from dsl093-040-174.pdx1.dsl.speakeasy.net ([66.93.40.174]:62667
	"EHLO aria.kroah.org") by vger.kernel.org with ESMTP
	id S1751248AbWCNWbP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 17:31:15 -0500
Date: Tue, 14 Mar 2006 14:31:05 -0800
From: Greg KH <gregkh@suse.de>
To: "Moore, Eric" <Eric.Moore@lsil.com>
Cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Christoph Hellwig <hch@infradead.org>, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH ] drivers/base/bus.c - export reprobe
Message-ID: <20060314223105.GA3130@suse.de>
References: <F331B95B72AFFB4B87467BE1C8E9CF5F36DC3B@NAMAIL2.ad.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F331B95B72AFFB4B87467BE1C8E9CF5F36DC3B@NAMAIL2.ad.lsil.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2006 at 03:01:05PM -0700, Moore, Eric wrote:
> On Tuesday, March 14, 2006 10:58 AM,  Greg KH wrote:
> 
> > 
> > Sure, that makes a lot of sense:
> > 
> > Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> > 
> > Oh, and please make that scsi wrapper function either
> > EXPORT_SYMBOL_GPL() or an inline function or macro.
> > 
> > thanks,
> > 
> 
> 
> Here we go again (hopefully no managled this time).

Nope, still in base64 :(

thanks,

greg k-h
