Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262346AbVBKVRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbVBKVRL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Feb 2005 16:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbVBKVRB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Feb 2005 16:17:01 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:45854 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262346AbVBKVQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Feb 2005 16:16:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=pz38peM/7jXs1fI8iZTHYf3qCEGOirSIcfYt0xSnStG/yMXKgFB4++tw5ZafYcIjfRtjNCWA35Y9Ciu2i4trsputfpq0Xo7NvHOZXwfjIv4/bsFCLXKKQdqr9TvsGNoP+SIZXQVtRWEjJE9fTkgHOVNMxal2Npxe6ak6nRF4QM8=
Message-ID: <58cb370e05021113164ec6113c@mail.gmail.com>
Date: Fri, 11 Feb 2005 22:16:45 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH 2.6.11-rc3 05/11] ide: fixes io_32bit race in ide_taskfile_ioctl()
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide <linux-ide@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <20050210083829.8739C4AB@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20050210083808.48E9DD1A@htj.dyndns.org>
	 <20050210083829.8739C4AB@htj.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

applied to ide-dev-2.6,  thanks

I need some more time for the other patches
