Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271287AbTG2HUJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 03:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271295AbTG2HUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 03:20:09 -0400
Received: from dialpool-210-214-80-170.maa.sify.net ([210.214.80.170]:12416
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S271287AbTG2HUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 03:20:07 -0400
Date: Tue, 29 Jul 2003 04:29:48 +0530
From: Balram Adlakha <b_adlakha@softhome.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1 NFS file transfer
Message-ID: <20030728225947.GA1694@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I cannot transfer files larger than 914 mb from an NFS mounted
filesystem to a local filesystem. A larger file than that is
simply cut of at 914 MB. This is using 2.6.0-test1, 2.4.20 
works fine. Can it be the version of mount I'm using? Its the
one that comes with util-linux-2.11y.
