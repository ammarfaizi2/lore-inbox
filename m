Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265117AbUAaSt2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Jan 2004 13:49:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265118AbUAaSt2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Jan 2004 13:49:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:9925 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S265117AbUAaSt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Jan 2004 13:49:27 -0500
Date: Sat, 31 Jan 2004 19:49:23 +0100
From: Jens Axboe <axboe@suse.de>
To: David Ford <david+challenge-response@blue-labs.org>
Cc: linux-kernel@vger.kernel.org, Mans Matulewicz <cybermans@xs4all.nl>
Subject: Re: ide-cdrom / atapi burning bug - 2.6.1
Message-ID: <20040131184923.GD11683@suse.de>
References: <1075511134.5412.59.camel@localhost> <20040131093438.GS11683@suse.de> <401BF122.2090709@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401BF122.2090709@blue-labs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 31 2004, David Ford wrote:
> I don't have an RW, but when my cdrom fixates, it stalls everything 
> while it's fixating.  I have an nForce chipset.  (2.6.x)

Does "everything" mean everything on that ide channel? If so, then
that's a hardware limitation.

-- 
Jens Axboe

