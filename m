Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264416AbTLBXCU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 18:02:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264422AbTLBXCU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 18:02:20 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:8201
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S264416AbTLBXCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 18:02:19 -0500
Date: Tue, 2 Dec 2003 15:02:16 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: bill davidsen <davidsen@tmr.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: libata in 2.4.24?
Message-ID: <20031202230216.GB4154@mis-mike-wstn.matchmail.com>
Mail-Followup-To: bill davidsen <davidsen@tmr.com>,
	linux-kernel@vger.kernel.org
References: <3FCB8312.3050703@rackable.com> <87iskz9hp6.fsf@stark.dyndns.tv> <20031202190646.GA9043@gtf.org> <877k1f9e1g.fsf@stark.dyndns.tv> <bqj41c$drr$1@gatekeeper.tmr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bqj41c$drr$1@gatekeeper.tmr.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 02, 2003 at 10:34:20PM +0000, Bill Davidsen wrote:
> after each O_SYNC write, so that's probably not practical. Clearly the
> best solution is a full SCSI implementation over PATA/SATA, but that
> would eliminate some of the justification for SCSI devices at premium
> prices.

In many ways, that is exactly what SATA is. :)
