Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932133AbVLPFU6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932133AbVLPFU6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Dec 2005 00:20:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbVLPFU5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Dec 2005 00:20:57 -0500
Received: from web50209.mail.yahoo.com ([206.190.38.50]:44733 "HELO
	web50209.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932133AbVLPFU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Dec 2005 00:20:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=bYJCt1wfBbWHvhj8s6EhiHOVlIk/MUTJM81+NUuZXkHpKiAFp0NvvA13syewgRswvDA946USzZzotxuPACZ/Mj2LSbKBt8Ae/1BLKe4dYHAvRLbJvz1V0PLHNExbc6mSMG3VBqZDC7vo/8jHGuKAKuZ+owk5t/wJPI1DSCHm3pY=  ;
Message-ID: <20051216052054.83256.qmail@web50209.mail.yahoo.com>
Date: Thu, 15 Dec 2005 21:20:54 -0800 (PST)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: [2.6 patch] i386: always use 4k stacks
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is that, with laptops, most of the time you DON'T have a choice:
HP and Dell primarily use a Broadcomm integrated wireless card in ther products.
As of yet, there is no open source driver for Broadcomm wireless.

>If 8k stacks get removed, yes. So if you have a chance to choose don't buy a 
>wifi card which doesn't have a native linux driver.
>
>Regards,
>ismail

I code, therefore I am

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
