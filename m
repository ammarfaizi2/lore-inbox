Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTGAWof (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 18:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263775AbTGAWof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 18:44:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:6618 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262115AbTGAWoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 18:44:34 -0400
Date: Tue, 01 Jul 2003 15:51:53 -0700 (PDT)
Message-Id: <20030701.155153.39188066.davem@redhat.com>
To: James.Bottomley@SteelEye.com
Cc: axboe@suse.de, grundler@parisc-linux.org, ak@suse.de, suparna@in.ibm.com,
       linux-kernel@vger.kernel.org, alex_williamson@hp.com,
       bjorn_helgaas@hp.com
Subject: Re: [RFC] block layer support for DMA IOMMU bypass mode
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1057077975.2135.54.camel@mulgrave>
References: <1057077975.2135.54.camel@mulgrave>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I personally don't care how this is done, as long as I can make
all the overhead from the checks go away on my platform by
defining the interface macro to do nothing :-)
