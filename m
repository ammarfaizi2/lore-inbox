Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268323AbUJTPxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268323AbUJTPxQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 11:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268370AbUJTPZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 11:25:08 -0400
Received: from mail3.iserv.net ([204.177.184.153]:16343 "EHLO mail3.iserv.net")
	by vger.kernel.org with ESMTP id S268368AbUJTPXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 11:23:08 -0400
Message-ID: <417682D3.501@didntduck.org>
Date: Wed, 20 Oct 2004 11:22:59 -0400
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7.3) Gecko/20040910
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
CC: Stas Sergeev <stsp@aknet.ru>, linux-kernel@vger.kernel.org
Subject: Re: X does not start. vm86old returns ENOSYS??
References: <200410201653.33233.vda@port.imtp.ilyichevsk.odessa.ua> <417672B3.4030801@didntduck.org> <200410201756.06694.vda@port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200410201756.06694.vda@port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> On Wednesday 20 October 2004 17:14, Brian Gerst wrote:
> 
>>Denis Vlasenko wrote:
>>
>>>How can vm86old from X return ENOSYS??
>>>I have no more ideas how to proceed from here.
>>
>>Are you trying to run a 32-bit X server on a 64-bit kernel?  x86-64 does 
>>not support vm86 mode.
> 
> 
> x86-64 with i845 chipset?! You must be kidding.

There are (or will be) Intel x86-64 chips.

--
				Brian Gerst
