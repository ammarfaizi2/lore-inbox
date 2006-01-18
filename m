Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932309AbWARFF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309AbWARFF7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 00:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932317AbWARFF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 00:05:58 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:27777 "EHLO
	ns1.utah-nac.org") by vger.kernel.org with ESMTP id S932309AbWARFF6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 00:05:58 -0500
Message-ID: <43CDC44E.6080808@wolfmountaingroup.com>
Date: Tue, 17 Jan 2006 21:30:06 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Max Waterman <davidmaxwaterman@fastmail.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: io performance...
References: <43CB4CC3.4030904@fastmail.co.uk> <43CDAFE3.8050203@fastmail.co.uk>
In-Reply-To: <43CDAFE3.8050203@fastmail.co.uk>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Max Waterman wrote:

> One further question. I get these messages 'in' dmesg :
>
> sda: asking for cache data failed
> sda: assuming drive cache: write through
>
> How can I force it to be 'write back'?



Forcing write back is a very bad idea unless you have a battery backed 
up RAID controller.   

Jeff

>
> Max.
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

