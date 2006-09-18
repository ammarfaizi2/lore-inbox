Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965402AbWIRFpw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965402AbWIRFpw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 01:45:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965404AbWIRFpw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 01:45:52 -0400
Received: from coyote.holtmann.net ([217.160.111.169]:33922 "EHLO
	mail.holtmann.net") by vger.kernel.org with ESMTP id S965402AbWIRFpv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 01:45:51 -0400
Subject: Re: Two vulnerabilities are founded,please confirm.
From: Marcel Holtmann <marcel@holtmann.org>
To: ADLab <adlab@venustech.com.cn>
Cc: linux-kernel@vger.kernel.org, zhangkai@venustech.com.cn
In-Reply-To: <4506C376.1080606@venustech.com.cn>
References: <4506C376.1080606@venustech.com.cn>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 07:45:50 +0200
Message-Id: <1158558350.30486.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> We are the ADLab, Venustech info Ltd CHINA. We have found two
> vulnerabilities within linux kernel. The first one is Linux kernel IP
> over ATM clip_mkip dereference freed pointer,and the second is Linux
> kernel Filesystem Mount Dead Loop.Please check out the detailes about
> the vulnerabilities at the end of this Email.
> 
> We are looking forward to hearing from you as soon as possible. If you
> need any more information, please do not hesitate to contact us. Thank
> you very much.

you might wanna split these two things into two separate posts. The
report for the ATM vulnerability should be send to the netdev mailing
list and for the filesystem vulnerability you should send it to the
linux-fsdevel mailing list.

Regards

Marcel


