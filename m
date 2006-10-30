Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964975AbWJ3NRK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964975AbWJ3NRK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 08:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWJ3NRK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 08:17:10 -0500
Received: from hu-out-0506.google.com ([72.14.214.237]:24753 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964912AbWJ3NRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 08:17:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qfa4ijiu8tSMMG61hjTYkYpspM2MD7WKm0i8dPmt9llZH4IJgSzMc/tiGnaFqOaZP2T5VYWYiWX7KsD7ncjLtCFvUYynnFgUHp3mWxegdCAlsAlRHNEd6TV9sjKWRKZGVJjI3Wodd2U8YM0yQGRZNihdmngu6ZindIiH3WPmu/M=
Message-ID: <9d2cd630610300517q5187043eieb0880047ddd03eb@mail.gmail.com>
Date: Mon, 30 Oct 2006 14:17:06 +0100
From: "Gregor Jasny" <gjasny@googlemail.com>
To: "Jens Axboe" <jens.axboe@oracle.com>
Subject: Re: 2.6.19-rc3 system freezes when ripping with cdparanoia at ioctl(SG_IO)
Cc: "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Jeff Garzik" <jgarzik@pobox.com>, linux-ide@vger.kernel.org
In-Reply-To: <20061030114503.GW4563@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <9d2cd630610291120l3f1b8053i5337cf3a97ba6ff0@mail.gmail.com>
	 <20061030114503.GW4563@kernel.dk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2006/10/30, Jens Axboe <jens.axboe@oracle.com>:
> Can you confirm that 2.6.18 works?

The reporter of [1] states that his SATA Thinkpad freezes with 2.6.17
and 2.6.18, too.

Gregor

[1] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=391901
