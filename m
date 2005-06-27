Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261739AbVF0DiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVF0DiG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Jun 2005 23:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVF0DiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Jun 2005 23:38:05 -0400
Received: from RT-soft-2.Moscow.itn.ru ([80.240.96.70]:34463 "HELO
	mail.dev.rtsoft.ru") by vger.kernel.org with SMTP id S261739AbVF0DiB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Jun 2005 23:38:01 -0400
Message-ID: <42BF7496.7080204@dev.rtsoft.ru>
Date: Mon, 27 Jun 2005 07:37:58 +0400
From: Vitaly Wool <vwool@dev.rtsoft.ru>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC] SPI core -- revisited
References: <20050626193621.8B8E44C4D1@abc.pervushin.pp.ru>	 <200506270049.10970.adobriyan@gmail.com> <1119819580.3215.47.camel@laptopd505.fenrus.org>
In-Reply-To: <1119819580.3215.47.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:

<snip>

>
> ... or just kill the wrappers entirely!
>
>  
>
Nothing's gonna work in DMA case if he kills the wrappers.

