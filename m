Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267925AbTBRTeZ>; Tue, 18 Feb 2003 14:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267935AbTBRTeZ>; Tue, 18 Feb 2003 14:34:25 -0500
Received: from nycsmtp2out.rdc-nyc.rr.com ([24.29.99.223]:32245 "EHLO
	nycsmtp2out.rdc-nyc.rr.com") by vger.kernel.org with ESMTP
	id <S267925AbTBRTeZ>; Tue, 18 Feb 2003 14:34:25 -0500
Message-ID: <3E5246A5.6020003@nyc.rr.com>
Date: Tue, 18 Feb 2003 09:43:49 -0500
From: John Weber <weber@nyc.rr.com>
Organization: My House
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: Luis Miguel Garcia <ktech@wanadoo.es>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bug in 2.5.62 kernel
References: <20030217173210.626efa05.ktech@wanadoo.es>
In-Reply-To: <20030217173210.626efa05.ktech@wanadoo.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luis Miguel Garcia wrote:
> it's about 2.5.62
> 
> I can do a make bzImage correctly
> I can do a make modules correctly
> 
> but
> 
> when I do a make modules_install I get a lot of
> depmod: Unresolved Symbols in /lib/modules/2.5.62/xxxx/xxxxx/xxxx.ko
> 
> What ca I do in order to see what's happening?

Do you have module-init-tools installed?  Kernels since 2.5.48 require
differed module utilities.



