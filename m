Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269439AbUJSOxR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269439AbUJSOxR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Oct 2004 10:53:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269458AbUJSOxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 10:53:16 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54918 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269439AbUJSOwz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 10:52:55 -0400
Message-ID: <41752A38.4080107@pobox.com>
Date: Tue, 19 Oct 2004 10:52:40 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Haverkamp <markh@osdl.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: Weird... 2.6.9 kills FC2 gcc
References: <4174697B.90306@pobox.com> <1098150587.1384.0.camel@peabody>	 <41747A28.2000101@pobox.com>  <41748A9D.2080306@pobox.com> <1098197339.1278.0.camel@markh1.pdx.osdl.net>
In-Reply-To: <1098197339.1278.0.camel@markh1.pdx.osdl.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Haverkamp wrote:
> On Mon, 2004-10-18 at 23:31 -0400, Jeff Garzik wrote:
> 
>>More data points:
>>
>>No problems at all on x86-64.
>>
>>No ICE on 32-bit x86 gcc 3.4.2, with 2.6.9 release kernel.
>>
>>So this ICE appears to be a bug specific to 3.3.x or perhaps Fedora.
>>
>>	Jeff
>>
> 
> 
> I tried building this on FC3 with a 3.4.2 gcc and it compiles OK.


Yeah, it looks like 3.3.x from FC2 and Debian both ICE, but 3.4.x (from 
any sources) is OK.

	Jeff


