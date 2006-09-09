Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932258AbWIIPN5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932258AbWIIPN5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Sep 2006 11:13:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWIIPN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Sep 2006 11:13:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:20212 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932258AbWIIPN4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Sep 2006 11:13:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cWFEdTTi2M6RKFsl+BjAKdTva1fAQtGZx9t18wis+IXZPAsHYx4PzwBCWrcR54aNVdjJjd3O3fIeUmZeHotYl81pV+CF8wz9tXlUig9UBhyHcbKgdmHV/urok+M5I9Ztl8dAHWJ6wIvEGAEJG6gXRLWYWUm+SbJnj3FbudfAFz8=
Message-ID: <82ecf08e0609090813g4889b659sfcb90e005cb42c14@mail.gmail.com>
Date: Sat, 9 Sep 2006 12:13:54 -0300
From: "Thiago Galesi" <thiagogalesi@gmail.com>
To: "Dave Jones" <davej@redhat.com>, "Thiago Galesi" <thiagogalesi@gmail.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: Re: Cpufreq not working in 2.6.18-rc6
In-Reply-To: <20060909144739.GS28592@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <82ecf08e0609090722p1ded935dm794d569278d60122@mail.gmail.com>
	 <20060909144739.GS28592@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  >
>  > CONFIG_X86_POWERNOW_K7_ACPI=y
>  > ..
>  > CONFIG_ACPI_PROCESSOR=m
>
> Does it start working again if you change ACPI_PROCESSOR=y ?

No. nothing changes

-- 
-
Thiago Galesi
