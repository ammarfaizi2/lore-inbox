Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261953AbTKLKem (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Nov 2003 05:34:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262009AbTKLKem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Nov 2003 05:34:42 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:40651 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261953AbTKLKel (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Nov 2003 05:34:41 -0500
Date: Wed, 12 Nov 2003 11:32:50 +0100
From: Jens Axboe <axboe@suse.de>
To: Okrain Genady <mafteah@mafteah.co.il>
Cc: Vid Strpic <vms@bofhlet.net>, Berke Durak <obdk65536@ouvaton.org>,
       linux-kernel@vger.kernel.org
Subject: Re: ide-scsi: "Sleeping function called from invalid context", 2.6.0-test9
Message-ID: <20031112103250.GC21141@suse.de>
References: <20031112080119.GD21265@home.bofhlet.net> <200311121206.55323.mafteah@mafteah.co.il> <20031112101910.GB21141@suse.de> <200311121231.39011.mafteah@mafteah.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200311121231.39011.mafteah@mafteah.co.il>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 12 2003, Okrain Genady wrote:
Content-Description: signed data
> I didn't test w/o scsi-emu.
> I have scsi-emu compiled in the kernel

Well compile a kernel without it then, and just use ide-cd. I wont
repeat for the Xth time why this is so, see any 2.6 'whats new' document
or search lkml for reasons.

-- 
Jens Axboe

