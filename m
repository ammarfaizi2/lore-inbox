Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283158AbRK2KzC>; Thu, 29 Nov 2001 05:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283168AbRK2Kyw>; Thu, 29 Nov 2001 05:54:52 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:39951 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S283158AbRK2Kyf>;
	Thu, 29 Nov 2001 05:54:35 -0500
Date: Thu, 29 Nov 2001 11:54:00 +0100
From: Jens Axboe <axboe@suse.de>
To: Todd Roy <todd_m_roy@yahoo.com>
Cc: linux-kernel@vger.kernel.org, linux-lvm@sistina.com
Subject: Re: lvm.c compilation errors with 2.5.1-pre2 and pre3
Message-ID: <20011129115400.B10601@suse.de>
In-Reply-To: <20011129104936.66773.qmail@web13604.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011129104936.66773.qmail@web13604.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29 2001, Todd Roy wrote:
> Hi all, I got these errors trying to
> compile 2.5.1-pre2 and pre3:

LVM is currently not in a working state, even though you remove the
BIO_HASHED bug test.

-- 
Jens Axboe

