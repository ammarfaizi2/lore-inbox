Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbULKUGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbULKUGs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 15:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbULKUGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 15:06:48 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:53436 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262001AbULKUGr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 15:06:47 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=sHxRCePNe4I/zFxgwjkjEdmGrTE66jm3fK6GsH8rnvCakfQAIPSLKZsRdgHRPk56BSs1acp+UuL6Wx0o5s7Gdg42C5fXRBTAimieVTkL/GNPo8C02b78xNpyBMfWExbkBCYil7ynmicRjoxlJSbdHSoXacUCOuSna9gsbuH6ttc=
Message-ID: <6fc3293d0412111206451e56b8@mail.gmail.com>
Date: Sat, 11 Dec 2004 21:06:46 +0100
From: Ronald Hummelink <ronald.hummelink@gmail.com>
Reply-To: Ronald Hummelink <ronald.hummelink@gmail.com>
To: "Camilo A. Reyes" <camilo@leamonde.no-ip.org>
Subject: Re: modprobe: QM_MODULES: Funtion not implemented on kernel 2.6.9
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041211195133.GA2210@leamonde.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <20041211195133.GA2210@leamonde.no-ip.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Dec 2004 13:51:33 -0600, Camilo A. Reyes
<camilo@leamonde.no-ip.org> wrote:
> Not sure if this has been raised before, but I get this error message
> every time I try to load a module, it is not the modprobe program it self
> causing the problem since I updated it to version 2.4.9 which is the
> latest out there...
> 
> Any suggestions? Please cc me as I am not on the list.

For 2.6 kernels you need the module-init-tools package which is
available from ftp.<yourcountry>.kernel.org or your favourite distro
vendor.
Latest version as of yesterday was 3.1

> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
