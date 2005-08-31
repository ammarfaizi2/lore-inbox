Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbVHaHL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbVHaHL7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 03:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932417AbVHaHL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 03:11:59 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:38179 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932414AbVHaHL6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 03:11:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ck0EFNsEEaTqfJyE9Jp3LrMdcq7D2eIi1VNp93Oww64VUiTzpUezuB49yw0j5Qz9Z+bluv2Ot3WB/XyhfTlmx5BDOYWj0lv0CZwIeP2m7Tf7TYQcdLPlWRiwK6oeIobbvmmGEpPWIHrYtmPDxpxfKqDh6SqxGnvzdH/UG9Uk3sA=
Message-ID: <1e33f5710508310011465457a0@mail.gmail.com>
Date: Wed, 31 Aug 2005 12:41:55 +0530
From: Gaurav Dhiman <gaurav4lkg@gmail.com>
To: raja <vnagaraju@effigent.net>
Subject: Re: Device Drivers
Cc: kernelnewbies@nl.linux.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <4315542C.6050503@effigent.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4315542C.6050503@effigent.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/31/05, raja <vnagaraju@effigent.net> wrote:
> Hi,
>     Would you please suggest me the good books for linux device
> drivers.Because I want to implement linux Char,Block,PCI,USB
> Drivers.Would you please suggest the good books pertaining to coding please

http://lwn.net/Kernel/LDD3/ - excellent book by rubini

-Gaurav

> 
> thanking you,
> Nagaraju,V
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
