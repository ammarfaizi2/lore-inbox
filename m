Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262209AbVHCKw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262209AbVHCKw7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 06:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVHCKw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 06:52:59 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:59520 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262209AbVHCKwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 06:52:53 -0400
Message-ID: <42F0A1F1.50603@gmail.com>
Date: Wed, 03 Aug 2005 12:52:33 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: mkrufky@m1k.net
CC: Sean Bruno <sean.bruno@dsl-only.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Testing RC kernels
References: <1123007589.24010.41.camel@jy.metro1.com> <42EFBD63.2060709@m1k.net>
In-Reply-To: <42EFBD63.2060709@m1k.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Krufky napsal(a):

> 2.6.13-rc* patches apply against 2.6.12  NOT 2.6.12.x

The best way to find out this, is to look into patch file on
--- linux-2.6.13-rc4/Makefile
line, a few lines below is -old version (to patch) and +new version as 
result ;).

