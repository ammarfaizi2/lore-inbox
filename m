Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964928AbVIMRnV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964928AbVIMRnV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 13:43:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964930AbVIMRnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 13:43:20 -0400
Received: from ozlabs.org ([203.10.76.45]:10661 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S964928AbVIMRnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 13:43:20 -0400
Date: Wed, 14 Sep 2005 03:13:12 +1000
From: Anton Blanchard <anton@samba.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Dipankar Sarma <dipankar@in.ibm.com>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.14-rc1] sym scsi boot hang
Message-ID: <20050913171312.GB26353@krispykreme>
References: <20050913124804.GA5008@in.ibm.com> <20050913131739.GD26162@krispykreme> <20050913142939.GE26162@krispykreme> <1126629345.4809.36.camel@mulgrave> <20050913164727.GA26353@krispykreme> <1126632760.4809.38.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126632760.4809.38.camel@mulgrave>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> That trace says the ibmvscsi driver (not sym2) has lost an I/O

Yep, this is another machine. The sym2 box is hanging at boot also.
Ill get a backtrace on it next.

Anton
