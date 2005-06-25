Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261363AbVFYWSn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbVFYWSn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Jun 2005 18:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbVFYWSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Jun 2005 18:18:43 -0400
Received: from trex.wsi.edu.pl ([195.117.114.133]:54999 "EHLO trex.wsi.edu.pl")
	by vger.kernel.org with ESMTP id S261363AbVFYWSl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Jun 2005 18:18:41 -0400
Message-ID: <42BDBC6E.8080706@trex.wsi.edu.pl>
Date: Sat, 25 Jun 2005 22:19:58 +0200
From: =?UTF-8?B?TWljaGHFgiBQaW90cm93c2tp?= <piotrowskim@trex.wsi.edu.pl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: Christian Kujau <evil@g-house.de>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] ORT - Oops Reporting Tool
References: <42BBE593.9090407@trex.wsi.edu.pl> <42BC0DCD.8020206@g-house.de> <4d8e3fd3050624085929581341@mail.gmail.com> <42BDD3FC.8090706@g-house.de>
In-Reply-To: <42BDD3FC.8090706@g-house.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Christian Kujau wrote:

> Paolo Ciarrocchi wrote:
>
>>
>> The commands that are requiring root capabilties are:
>> lspci -vvv lsusb -v
>
>
> i still dislike the idea being forced to be root, does the attached 
> patch looks ok?
>
>
Maybe something like that

sudo lspci -vvv
sudo lsusb -v

?

Regards,
Michał Piotrowski
