Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262197AbSJ0X5l>; Sun, 27 Oct 2002 18:57:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262214AbSJ0X5l>; Sun, 27 Oct 2002 18:57:41 -0500
Received: from as3-1-8.ras.s.bonet.se ([217.215.75.181]:52166 "EHLO
	garbo.kenjo.org") by vger.kernel.org with ESMTP id <S262197AbSJ0X5k>;
	Sun, 27 Oct 2002 18:57:40 -0500
Subject: Re: rootfs exposure in /proc/mounts
From: Kenneth Johansson <ken@kenjo.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andreas Haumer <andreas@xss.co.at>,
       linux-kernel@vger.kernel.org, willy@w.ods.org
In-Reply-To: <20021027150936.A20310@infradead.org>
References: <Pine.GSO.4.21.0210261458460.29768-100000@steklov.math.psu.edu>
	<3DBAE931.7000409@domdv.de> <3DBAEC79.5050605@pobox.com>
	<3DBBBE1B.5050809@xss.co.at> <3DBC0007.8020005@pobox.com> 
	<20021027150936.A20310@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 28 Oct 2002 01:03:28 +0100
Message-Id: <1035763409.4176.5.camel@tiger>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-27 at 16:09, Christoph Hellwig wrote:
> you might have very different mounts in different processes.

You can ?? apart from chroot that can make things interesting  how do
you do this?




