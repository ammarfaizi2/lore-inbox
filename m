Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261991AbUKJVDe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbUKJVDe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 16:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261992AbUKJVDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 16:03:34 -0500
Received: from mproxy.gmail.com ([216.239.56.246]:59805 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261991AbUKJVDb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 16:03:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=S79BxLYSFd9KgfHLTI5kk7jUXVi1P8bwttJr3BUECACftaL2KLj7lyBE/Apl2lYd32K3H8Z07l2WP2oScUuNbaQCXp4O7wAroVxHmLzyVr1dIfjDoKAnGGbUrB5I0YoDHXYDmFb5xYIQATBDGFgXgKoCvA1ppW60KPQo9Rqfh0I=
Message-ID: <543d091304111013035563e7f6@mail.gmail.com>
Date: Wed, 10 Nov 2004 19:03:30 -0200
From: Alexandre Costa <alebyte@gmail.com>
Reply-To: Alexandre Costa <alebyte@gmail.com>
To: linux-os@analogic.com
Subject: Re: DEVFS_FS
Cc: Linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0411101544080.19616@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <Pine.LNX.4.61.0411101544080.19616@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Nov 2004 15:46:06 -0500 (EST), linux-os
<linux-os@chaos.analogic.com> wrote:
 
> What is the approved substitute for DEVFS_FS that is marked
> obsolete?

udev
http://www.kernel.org/pub/linux/utils/kernel/hotplug/udev.html

-- 
Alexandre Costa
Linux Reg. User: 129596
alebyte at gmail dot com
ICQ UIN nº: 19607379
