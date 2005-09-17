Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750931AbVIQF00@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750931AbVIQF00 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Sep 2005 01:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750934AbVIQF00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Sep 2005 01:26:26 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:43702 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP
	id S1750929AbVIQF0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Sep 2005 01:26:25 -0400
X-ORBL: [67.124.117.85]
Date: Fri, 16 Sep 2005 22:26:04 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Joakim Tysseng <joakim.tysseng@opoint.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFS lockup on 2.6.12-1.1376_FC3smp
Message-ID: <20050917052604.GA32470@taniwha.stupidest.org>
References: <43295F60.6050303@opoint.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43295F60.6050303@opoint.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 01:47:44PM +0200, Joakim Tysseng wrote:

> I'm experiencing a serious problem with XFS on 2.6.12-1.1376_FC3smp

Red Hat kernel? 4K stacks right?

> running XFS on top of LVM.

Are 4k stacks with XFS over LVM well tested?  In the past there have
been issues and it's not clear all of these have been resolved.
