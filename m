Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266540AbSKZTM0>; Tue, 26 Nov 2002 14:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266514AbSKZTM0>; Tue, 26 Nov 2002 14:12:26 -0500
Received: from mail.wincom.net ([209.216.129.3]:39437 "EHLO wincom.net")
	by vger.kernel.org with ESMTP id <S266540AbSKZTMZ>;
	Tue, 26 Nov 2002 14:12:25 -0500
From: "Dennis Grant" <trog@wincom.net>
Reply-to: trog@wincom.net
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, dpaun@rogers.com,
       Rusty Lynch <rusty@linux.co.intel.com>, trog@wincom.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Tue, 26 Nov 2002 14:28:29 -0500
Subject: Re: A Kernel Configuration Tale of Woe
X-Mailer: CWMail Web to Mail Gateway 2.4e, http://netwinsite.com/top_mail.htm
Message-id: <3de3cc8d.54dd.0@wincom.net>
X-User-Info: 129.9.26.53
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>On Tue, 2002-11-26 at 18:04, Dimitrie O. Paun wrote:
>> On November 26, 2002 12:35 pm, Rusty Lynch wrote:

>>> So how would you deal with somebody contributing bogus 
>>> mappings? What if somebody was just wrong, or uploading a
>>> mapping in error?
 
>> The same applies to the kernel code, or any other open 
>> source project:  How do you deal with somebody contributing
>> bogus code?
 
>> Somehow things work out, as we have already witnessed.

> For boards its not that simple. Many vendors release multiple > utterly different
machines with the same box, bios and ident.
> The customer is told "IDE CD, 100mbit ethernet", the customer
> gets random cheapest going ethernet.

Agreed - so then the association between "board" and "chipset" must be capable
of being multi-valued, and when there is a mult-valued match there must be some
means of further interrogating the user (or user agent) for more information.


DG
