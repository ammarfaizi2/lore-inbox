Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964897AbWJ3NOM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964897AbWJ3NOM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 08:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964857AbWJ3NOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 08:14:12 -0500
Received: from hu-out-0506.google.com ([72.14.214.239]:30126 "EHLO
	hu-out-0506.google.com") by vger.kernel.org with ESMTP
	id S964899AbWJ3NOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 08:14:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GerJaD64PrCvfQ48442vfmKLcEqxn/oCrEXZFOhQ+MlG4ktNoSSf/C/3CpCFM+VylZmxCyz+7HlfZjgam87qOKSWJFJASfPXlux9W6QLlYX3XPnP0/w3fnk62vxvsOZMSBe5aB/EgIEhQ5BGxXIY7O1BhLxYAGoaJ8btOLkkWyQ=
Message-ID: <9d2cd630610300514w355aaf34ue23e4558d713e110@mail.gmail.com>
Date: Mon, 30 Oct 2006 14:14:08 +0100
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

I've ripped a lot of CDs with this drive and 2.6.18. But I accessed
the drive via the old ide drivers. How Do I enable libata for the PATA
part of my IDE chipset in 2.6.18?

Gregor
