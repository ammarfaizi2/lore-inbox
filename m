Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932457AbWJ3N0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932457AbWJ3N0L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 08:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWJ3N0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 08:26:11 -0500
Received: from brick.kernel.dk ([62.242.22.158]:27155 "EHLO kernel.dk")
	by vger.kernel.org with ESMTP id S932435AbWJ3N0J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 08:26:09 -0500
Date: Mon, 30 Oct 2006 14:27:47 +0100
From: Jens Axboe <jens.axboe@oracle.com>
To: Gregor Jasny <gjasny@googlemail.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org
Subject: Re: 2.6.19-rc3 system freezes when ripping with cdparanoia at ioctl(SG_IO)
Message-ID: <20061030132745.GE4563@kernel.dk>
References: <9d2cd630610291120l3f1b8053i5337cf3a97ba6ff0@mail.gmail.com> <20061030114503.GW4563@kernel.dk> <9d2cd630610300517q5187043eieb0880047ddd03eb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d2cd630610300517q5187043eieb0880047ddd03eb@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 30 2006, Gregor Jasny wrote:
> 2006/10/30, Jens Axboe <jens.axboe@oracle.com>:
> >Can you confirm that 2.6.18 works?
> 
> The reporter of [1] states that his SATA Thinkpad freezes with 2.6.17
> and 2.6.18, too.
> 
> Gregor
> 
> [1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=391901

Ok, mainly just checking if this was a potential dupe of another bug.

-- 
Jens Axboe

