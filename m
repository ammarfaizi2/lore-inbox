Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262689AbUJ0TqU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbUJ0TqU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 15:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262576AbUJ0TnD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 15:43:03 -0400
Received: from terminus.zytor.com ([209.128.98.78]:62356 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S262630AbUJ0Tkg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 15:40:36 -0400
Message-ID: <417FF998.7050505@zytor.com>
Date: Wed, 27 Oct 2004 12:40:08 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Bill Davidsen <davidsen@tmr.com>
CC: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Tonnerre <tonnerre@thundrix.ch>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Erik Andersen <andersen@codepoet.org>, uclibc@uclibc.org
Subject: Re: The naming wars continue...
References: <417F2251.7010404@zytor.com><417F2251.7010404@zytor.com> <200410271133.25701.vda@port.imtp.ilyichevsk.odessa.ua> <417FF43C.5050208@tmr.com>
In-Reply-To: <417FF43C.5050208@tmr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bill Davidsen wrote:
> 
> I guess someone was nervous about mounting a local /usr/local on a 
> (possibly) network mounted /usr and theu /opt, but that's a guess on my 
> part as well.
> 

/opt is structured, /usr/local is not; that's the big difference.

	-hpa

