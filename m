Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266677AbUBMC3g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 21:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266685AbUBMC3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 21:29:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:16784 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266677AbUBMC3f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 21:29:35 -0500
Date: Fri, 13 Feb 2004 02:29:34 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Cc: Jamie Lokier <jamie@shareable.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Message-ID: <20040213022934.GA8858@parcelfarce.linux.theplanet.co.uk>
References: <20040209115852.GB877@schottelius.org> <200402121655.39709.robin.rosenberg.lists@dewire.com> <20040213003839.GB24981@mail.shareable.org> <200402130216.53434.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402130216.53434.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 13, 2004 at 02:16:53AM +0100, Robin Rosenberg wrote:
> Yes, so ext3&co. should be equipped with charset options just the other so
> it can be fixed by the user or in some cases the mount tools. 
> 
> Is there a place to store character set information in these file systems?

Bullshit.  Just as there is no timezone common for all users, there is no
charset common for all of them.  Charset of _machine_ doesn't make any sense
at all - toy operating systems nonwithstanding.
