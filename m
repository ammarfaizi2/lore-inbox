Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264859AbTAEP3L>; Sun, 5 Jan 2003 10:29:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264863AbTAEP3L>; Sun, 5 Jan 2003 10:29:11 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:40341 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S264859AbTAEP3L>;
	Sun, 5 Jan 2003 10:29:11 -0500
Date: Sun, 5 Jan 2003 16:37:28 +0100
From: Jens Axboe <axboe@suse.de>
To: sean darcy <seandarcy@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.54 ide-scsi and cdrecord
Message-ID: <20030105153728.GG13332@suse.de>
References: <F27Iu6VXNjimExOpK7u00012a9a@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F27Iu6VXNjimExOpK7u00012a9a@hotmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04 2003, sean darcy wrote:
> What am I missing? I thought we didn't need the scsi layer anymore.

cdrecord -dev=/dev/hdX

-- 
Jens Axboe

