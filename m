Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264572AbTLCN0d (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 08:26:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264573AbTLCN0d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 08:26:33 -0500
Received: from gw.uk.sistina.com ([62.172.100.98]:31763 "EHLO
	gw.uk.sistina.com") by vger.kernel.org with ESMTP id S264572AbTLCN0c
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 08:26:32 -0500
Date: Wed, 3 Dec 2003 13:26:30 +0000
From: Alasdair G Kergon <agk@uk.sistina.com>
To: linux-lvm@sistina.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [linux-lvm] LVM2 related OOPS in 2.4.22 (kernel BUG at kcopyd.c:130!)
Message-ID: <20031203132630.O16901@uk.sistina.com>
Mail-Followup-To: linux-lvm@sistina.com, linux-kernel@vger.kernel.org
References: <1070130848.15958.6.camel@dom>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1070130848.15958.6.camel@dom>; from stefan@x-cellent.com on Sat, Nov 29, 2003 at 07:34:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 29, 2003 at 07:34:08PM +0100, Stefan Majer wrote:
> First i created a logical volume and the about 5 snapshots.
> Then i wanted to create a filesystem on the source LV with
> mkreiserfs.
 
>   Driver version:  4.0.1
 
Please try a newer kernel driver (4.0.5) included in the
device-mapper tarball.

Alasdair
-- 
agk@uk.sistina.com
