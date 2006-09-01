Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751697AbWIAPzQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbWIAPzQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 11:55:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751703AbWIAPzP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 11:55:15 -0400
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:9837 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751691AbWIAPzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 11:55:14 -0400
Date: Fri, 1 Sep 2006 08:55:10 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Johnny Strom <johnny.strom@osp.fi>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: Patch to make VIA sata board bootable again.
Message-ID: <20060901155510.GA28345@tuatara.stupidest.org>
References: <44F7EC15.8040800@osp.fi> <20060901014745.750e69d1.akpm@osdl.org> <44F81013.4030904@osp.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44F81013.4030904@osp.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 01:48:51PM +0300, Johnny Strom wrote:

> No it is the same problem with 2.6.18-rc5.

Did either the patches from Daniel Drake or Sergio Monteiro Basto
help?

> Attached an new diff.

Which breaks other a different class of machines.  A can you try -mm,
there is a patch in that and tell us if that works?
