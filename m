Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262020AbUFNILJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262020AbUFNILJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 04:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbUFNILJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 04:11:09 -0400
Received: from holomorphy.com ([207.189.100.168]:52126 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262020AbUFNILG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 04:11:06 -0400
Date: Mon, 14 Jun 2004 01:11:03 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [6/12] fix advansys.c highmem bugs
Message-ID: <20040614081103.GF1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040614003148.GO1444@holomorphy.com> <20040614003331.GP1444@holomorphy.com> <20040614003459.GQ1444@holomorphy.com> <20040614003605.GR1444@holomorphy.com> <20040614003708.GS1444@holomorphy.com> <20040614003835.GT1444@holomorphy.com> <20040614003929.GU1444@holomorphy.com> <20040613212611.1f548003.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040613212611.1f548003.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>>   * Added basic highmem support in drivers/scsi/advansys.c

On Sun, Jun 13, 2004 at 09:26:11PM -0700, Andrew Morton wrote:
> 14 out of 16 hunks FAILED -- saving rejects to file drivers/scsi/advansys.c.rej
> Looks like this has been addressed in the bk scsi tree, only differently.

I'm in a maze of bk trees, all slightly different. Then the dungeon
collapses. I generated this stuff vs. 2.6.x-bk-CURRENT, presuming there
was some sort of recency to either the patches or the tree I was
looking at. Apparently, there was such for neither of the two.


-- wli
