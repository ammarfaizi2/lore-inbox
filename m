Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319033AbSHMRQM>; Tue, 13 Aug 2002 13:16:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319035AbSHMRQM>; Tue, 13 Aug 2002 13:16:12 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:14609 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S319033AbSHMRQK>;
	Tue, 13 Aug 2002 13:16:10 -0400
Date: Tue, 13 Aug 2002 10:16:05 -0700
From: Greg KH <greg@kroah.com>
To: "Cameron, Steve" <Steve.Cameron@hp.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.30 breaks cciss driver?
Message-ID: <20020813171605.GC21149@kroah.com>
References: <45B36A38D959B44CB032DA427A6E10640167D023@cceexc18.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45B36A38D959B44CB032DA427A6E10640167D023@cceexc18.americas.cpqcorp.net>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Tue, 16 Jul 2002 16:03:06 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 10:09:32AM -0500, Cameron, Steve wrote:
> Message 2 in thread 
> Greg KH (greg@kroah.com) wrote:
> >
> > Are you running in "devfs=only" mode?  If so, the changes I made
> > probably are the cause of this.
> > 
> 
> No.  The changes that broke it are to do with the sizes[]
> being gone, I think.  That yours?

Nope, thankfully :)

Sorry, but I have no idea of what could be wrong.

greg k-h
