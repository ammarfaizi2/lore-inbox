Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265865AbUAUAIS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 19:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265864AbUAUAIS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 19:08:18 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:9740 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265865AbUAUAIN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 19:08:13 -0500
Date: Wed, 21 Jan 2004 00:08:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: bunk@fs.tum.de, James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: [2.6 patch] show "Fusion MPT device support" menu only if BLK_DEV_SD
Message-ID: <20040121000810.A23862@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, bunk@fs.tum.de,
	James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <20040120232507.GC6441@fs.tum.de> <20040120233537.A23375@infradead.org> <20040120160346.7e466ad2.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040120160346.7e466ad2.akpm@osdl.org>; from akpm@osdl.org on Tue, Jan 20, 2004 at 04:03:46PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 04:03:46PM -0800, Andrew Morton wrote:
>           [2] In order enable capability to boot the linux kernel
>           natively from a Fusion MPT target device, you MUST
>           answer Y here! (currently requires CONFIG_BLK_DEV_SD)

Well, that's true for any LLDD.

