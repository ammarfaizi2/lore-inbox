Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWDTHAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWDTHAt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 03:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWDTHAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 03:00:49 -0400
Received: from smtpout.mac.com ([17.250.248.184]:54000 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750746AbWDTHAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 03:00:49 -0400
In-Reply-To: <963E9E15184E2648A8BBE83CF91F5FAF5154F6@titanium.secgo.net>
References: <963E9E15184E2648A8BBE83CF91F5FAF5154F6@titanium.secgo.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B9A0A941-5CD4-40C6-99D9-1032AE90EE23@mac.com>
Cc: James Morris <jmorris@namei.org>, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: searching exported symbols from modules
Date: Thu, 20 Apr 2006 03:00:08 -0400
To: Antti Halonen <antti.halonen@secgo.com>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 20, 2006, at 02:12:09, Antti Halonen wrote:
>>> This is commercial module and will not be merged into mainline.
>>
>> Is it GPL or compatible?
>
> Nope, MODULE_LICENSE("Proprietary").

This makes me wonder why the hell you think you'll get help from this  
(open-source) list.  A large number of people on this list (including  
copyright-holders) consider what you are doing blatantly illegal,  
although nobody has yet gone to court over it.  Please reconsider  
your decision and either opensource your code or find a way to do it  
in userspace.  For example, it is quite easy to write a low-latency  
USB device driver completely in userspace with only standard kernel  
drivers.

Cheers,
Kyle Moffett

