Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268579AbUHLOiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268579AbUHLOiy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 10:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268580AbUHLOiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 10:38:54 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:34796 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S268579AbUHLOiv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 10:38:51 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: [PATCH] add PCI ROMs to sysfs
Date: Thu, 12 Aug 2004 07:38:26 -0700
User-Agent: KMail/1.6.2
Cc: Greg KH <greg@kroah.com>, linux-pci@atrey.karlin.mff.cuni.cz,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040806211413.77833.qmail@web14926.mail.yahoo.com> <20040811181236.GD14979@kroah.com> <20040812012843.GA2122@dmt.cyclades>
In-Reply-To: <20040812012843.GA2122@dmt.cyclades>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408120738.26696.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, August 11, 2004 6:28 pm, Marcelo Tosatti wrote:
> That made me curious, what is the rationale behind
>
> (C) Copyright 2004 Silicon Graphics, Inc. Jesse Barnes <jbarnes@sgi.com>
>
> works and the previous suggested
>
> (C) Copyright 2004 Silicon Graphics, Inc.
> 	Jesse Barnes <jbarnes@sgi.com>
>
> doesnt?
>
> I know its a bit offtopic, but still, if you know the reason, would be
> great to hear :) Bet others will also like to hear that.

My thought was that the second one doesn't list me as the copyright holder, 
only the author, which is just what I wanted.  To me, the first one seems to 
indicate that the copyright is shared between myself and the entity that owns 
it, which is incorrect.

Jesse
