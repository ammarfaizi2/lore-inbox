Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbUASVYu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 16:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbUASVYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 16:24:50 -0500
Received: from outbound01.telus.net ([199.185.220.220]:43204 "EHLO
	priv-edtnes03-hme0.telusplanet.net") by vger.kernel.org with ESMTP
	id S263695AbUASVYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 16:24:47 -0500
Subject: Re: Scsi devices not found
From: Bob Gill <gillb4@telusplanet.net>
To: Ben Collins <bcollins@debian.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040119200452.GM473@phunnypharm.org>
References: <1074545082.18958.9.camel@localhost.localdomain>
	 <20040119200452.GM473@phunnypharm.org>
Content-Type: text/plain
Message-Id: <1074547485.3326.1.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 19 Jan 2004 14:24:45 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Excellent,  Thank You!

On Mon, 2004-01-19 at 13:04, Ben Collins wrote:
> On Mon, Jan 19, 2004 at 01:44:43PM -0700, Bob Gill wrote:
> > Hi.  I was able to attach two firewire devices to 2.6.1-bk2, but with
> > 2.6.1-bk4 and 2.6.1-bk5 they cannot be found (and they really are still
> > attached).  gscanbus cannot find them (nor can /proc/partitions or
> > /proc/scsi/scsi).  gscanbus reports:
> 
> I have this fixed in my tree. Just waiting on Linus or Andrew to pull
> the two fixes in. If you can't wait, get the trunk from our SVN repo on
> www.linux1394.org.

