Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261815AbSJQGsS>; Thu, 17 Oct 2002 02:48:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261819AbSJQGsS>; Thu, 17 Oct 2002 02:48:18 -0400
Received: from tufnell.london1.poggs.net ([193.109.194.18]:25815 "EHLO
	tufnell.london1.poggs.net") by vger.kernel.org with ESMTP
	id <S261815AbSJQGsR>; Thu, 17 Oct 2002 02:48:17 -0400
Message-ID: <3DAE5EF3.2020108@POGGS.CO.UK>
Date: Thu, 17 Oct 2002 07:55:47 +0100
From: Peter Hicks <Peter.Hicks@POGGS.CO.UK>
Organization: Poggs Computer Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-gb, en-us, en-au, en-ie, en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19 - bug in page_alloc.c?
References: <3DAE0047.3050900@POGGS.CO.UK> <20021016.172047.51833897.davem@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David

David S. Miller wrote:

>Do you have the NVIDIA module loaded when this happens?
>
Yes - the latest version.  Is this the cause?

'dmesg' doesn't show the kernel as tainted, however.



Peter.

