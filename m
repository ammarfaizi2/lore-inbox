Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVGIVV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVGIVV5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Jul 2005 17:21:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261736AbVGIVV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Jul 2005 17:21:57 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:23372 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261735AbVGIVV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Jul 2005 17:21:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=MxlfgraEdmb/zrXFlgrB0hB+NaMYw+Dw+lzQACralhK+GxnFAFN1fGELM5T2TxPc/zAovOWHmHSlwRNyG0bfBHqRk30aS4V7YGJCSYlqwRaMu4BiKPT7X47kCC5jrQUh1rROGjKrSYt9siPRl7UhG5X1IIGywcHVXVVqJjb6lMI=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: federico <xaero@inwind.it>
Subject: Re: [PATCH] ability to change SysRq scancode
Date: Sun, 10 Jul 2005 01:28:46 +0400
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org
References: <42D03731.9060809@inwind.it>
In-Reply-To: <42D03731.9060809@inwind.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507100128.46959.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 July 2005 00:44, federico wrote:
> i release this patch because my keyboard ("Mitsumi Electric Apple
> Extended USB Keyboard" Bus=0003 Vendor=05ac Product=0205 Version=0122)
> doesn't have a PrintScr key, so cannot send the right scancode, and
> KEY_SYSRQ needs to be modified.
> 
> i hope that i've done in the right way ;)

diff -uprN please.

> it's tested by me, and it's working, yeah i'm pressing the SAK with F13 :P

