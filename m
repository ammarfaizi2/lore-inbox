Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268137AbUJDNCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268137AbUJDNCa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 09:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268138AbUJDNC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 09:02:29 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:9113 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S268137AbUJDNC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 09:02:27 -0400
Date: Mon, 4 Oct 2004 14:59:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [bug] 2.6.8: CDROM_SEND_PACKET ioctls failing as non-root on ide scsi drives
Message-ID: <20041004125937.GQ2287@suse.de>
References: <20041004130941.GE19341@lkcl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041004130941.GE19341@lkcl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04 2004, Luke Kenneth Casson Leighton wrote:
> kernel 2.6.8.  ioctl ("/dev/hdc", CDROM_SEND_PACKET, cmd)

please search the archives, this has been discussed extensively over the
last month. frankly, I don't know how you were even able to miss it :)

-- 
Jens Axboe

