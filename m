Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264732AbTFAVUj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Jun 2003 17:20:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264733AbTFAVUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Jun 2003 17:20:38 -0400
Received: from smtp6.wanadoo.fr ([193.252.22.28]:14977 "EHLO
	mwinf0304.wanadoo.fr") by vger.kernel.org with ESMTP
	id S264732AbTFAVUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Jun 2003 17:20:38 -0400
Message-ID: <3EDA7148.4070907@ifrance.com>
Date: Sun, 01 Jun 2003 23:34:00 +0200
From: Yoann <linux-yoann@ifrance.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030524 Debian/1.3.1-1.he-1
X-Accept-Language: fr, fr-fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.5.70 compilation fails
References: <D59A003F-9456-11D7-AF84-00039346F142@mac.com>
In-Reply-To: <D59A003F-9456-11D7-AF84-00039346F142@mac.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stewart Smith wrote:
> On Monday, June 2, 2003, at 01:41  AM, Yoann wrote:
> 
>> make[3]: *** No rule to make target `drivers/ide/ide-geometry.s', 
>> needed by
>> `drivers/ide/ide-geometry.o'.  Stop.
> 
> 
> ide-geometry.c was removed with 2.5.70 (was in 2.5.69), your source 
> directory probably isn't patched properly or something else weird. Grab 
> a fresh tarball or freshly patch up to 2.5.70.

ok, thanks a lot, it compiled without problem, ;)  and it's running as well :

# uname -a
Linux von 2.5.70 #1 Sun Jun 1 21:22:58 CEST 2003 i686 GNU/Linux

Yoann

