Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbTICMyr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 08:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbTICMyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 08:54:44 -0400
Received: from ivoti.terra.com.br ([200.176.3.20]:10477 "EHLO
	ivoti.terra.com.br") by vger.kernel.org with ESMTP id S262041AbTICMyk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 08:54:40 -0400
Message-ID: <3F55E4E8.1010208@terra.com.br>
Date: Wed, 03 Sep 2003 09:56:08 -0300
From: Felipe W Damasio <felipewd@terra.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Needed include in usb/gadget/net2280
References: <3F514CDC.9060203@terra.com.br> <20030902173846.GA17995@kroah.com>
In-Reply-To: <20030902173846.GA17995@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Greg,

Greg KH wrote:
> On Sat, Aug 30, 2003 at 10:18:20PM -0300, Felipe W Damasio wrote:
> 
>>	Hi Greg,
>>
>>	Attached is a trivial patch which includes the needed 
>>	linux/version.h header file.
>>
>>	This is based on Randy's checkversion.pl script.
>>
>>	Please consider applying.
> 
> 
> Thanks, but I already have this change in my USB tree.  I'll push them
> all to Linus later today.

	I couldn't find this patch on your merge with Linus:

http://linux.bkbits.net:8080/linux-2.5/patch@1.1406.3.1?nav=index.html|ChangeSet@-1d|cset@1.1406.3.1

	Or you're talking about another USB tree merge with Linus? :)

	Cheers,

Felipe

