Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265552AbUBJEcZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 23:32:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265572AbUBJEcZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 23:32:25 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:58531 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S265552AbUBJEcY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 23:32:24 -0500
Date: Mon, 9 Feb 2004 20:32:12 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Matthias Urlichs <smurf@smurf.noris.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UTF-8 in file systems? xfs/extfs/etc.
Message-ID: <20040210043212.GF18674@srv-lnx2600.matchmail.com>
Mail-Followup-To: Matthias Urlichs <smurf@smurf.noris.de>,
	linux-kernel@vger.kernel.org
References: <20040209115852.GB877@schottelius.org> <pan.2004.02.09.13.36.23.911729@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pan.2004.02.09.13.36.23.911729@smurf.noris.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 09, 2004 at 02:36:24PM +0100, Matthias Urlichs wrote:
> Hi, Nico Schottelius wrote:
> 
> > What Linux supported filesystems support UTF-8 filenames?
> 
> Filenames, to the kernel, are a sequence of 8-bit things commonly
> called "bytes" or "octets", excluding '/' and '\0'.
> 

You can have "/" in the filename also, though that could be encoded somehow...
