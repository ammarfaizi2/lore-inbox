Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268062AbUHFOZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268062AbUHFOZm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 10:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268066AbUHFOZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 10:25:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:19391 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268062AbUHFOZh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 10:25:37 -0400
Date: Fri, 6 Aug 2004 16:25:17 +0200
From: Jens Axboe <axboe@suse.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: erik@harddisk-recovery.com, James.Bottomley@steeleye.com,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-ID: <20040806142516.GG10274@suse.de>
References: <200408061420.i76EKUHp006230@burner.fokus.fraunhofer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408061420.i76EKUHp006230@burner.fokus.fraunhofer.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 06 2004, Joerg Schilling wrote:
> You know what a cut/paste error is?
> 
> BTW: this could be avoided if Linux would supply correct termcap/terminfo
> entries for xterm so the screen would not go white on black on
> every odd try :-(

Your mail would have been equally wrong had you written SG_MAX_SENSE.
It's a bug in cdrecord, period. Like Erik said, you could help your
image considerably admitting that instead of changing directions.

-- 
Jens Axboe

