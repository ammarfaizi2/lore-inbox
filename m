Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263421AbVHFTMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263421AbVHFTMz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 15:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVHFTMz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 15:12:55 -0400
Received: from coderock.org ([193.77.147.115]:2029 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S263421AbVHFTMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 15:12:31 -0400
Date: Sat, 6 Aug 2005 21:12:33 +0200
From: Domen Puncer <domen@coderock.org>
To: Jiri Slaby <jirislaby@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rc4-mm1] drivers/char/isicom.c old api rewritten
Message-ID: <20050806191233.GA7322@homer.coderock.org>
References: <42EE9C0F.30004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42EE9C0F.30004@gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/08/05 00:02 +0200, Jiri Slaby wrote:
> Hello.
> Could you send me critics and bugs?

You have much bigger chances of someone reviewing the patch if you
at least split code changes and whitespace/type cleanups. 65k is a lot.

> Could somebody test it (but NOT now)?
> Thanks.
> 
> drivers/char/isicom.c  | 1610 
> ++++++++++++++++++++++++-------------------------
> include/linux/isicom.h |    8
> 2 files changed, 817 insertions(+), 801 deletions(-)
> 
> Here it is (about 65 KiB):

It should deserve a few bytes of description ;-)

> http://www.fi.muni.cz/~xslaby/lnx/isi.txt
> 
