Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261300AbULTOJB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbULTOJB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 09:09:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbULTOJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 09:09:00 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:55171 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261300AbULTOI7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 09:08:59 -0500
Date: Mon, 20 Dec 2004 15:08:58 +0100
From: Jens Axboe <axboe@suse.de>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /sys/block vs. /sys/class/block
Message-ID: <20041220140858.GA2773@suse.de>
References: <1103526532.5320.33.camel@gaston> <41C68A6D.6060801@yahoo.com.au> <1103534958.14050.13.camel@gaston> <41C69EF3.6010207@yahoo.com.au> <20041220094506.GM3140@suse.de> <Pine.LNX.4.61.0412201236570.14552@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0412201236570.14552@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


(please follow list etiquette, don't trim cc lists)

On Mon, Dec 20 2004, Jan Engelhardt wrote:
> >Ditto, the question is how to move it with as little pain as possible...
> >I think the symlink approach would be fine.
> 
> Wow.. I don't even have /sys/class/block (2.6.9-rc2)

That is Ben's point, it is currently misplaced.

-- 
Jens Axboe

