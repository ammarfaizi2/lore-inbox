Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265206AbTIDO7P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 10:59:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265152AbTIDO7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 10:59:15 -0400
Received: from gharelay-av-smtp1.gmessaging.net ([194.51.201.2]:19081 "EHLO
	eads-av-smtp1.gmessaging.net") by vger.kernel.org with ESMTP
	id S265206AbTIDO7I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 10:59:08 -0400
Date: Thu, 04 Sep 2003 16:56:48 +0200
From: Yann Droneaud <yann.droneaud@mbda.fr>
Subject: Re: nasm over gas?
In-reply-to: <20030904104245.GA1823@leto2.endorphin.org>
To: fruhwirth clemens <clemens-dated-1063536166.2852@endorphin.org>
Cc: linux-kernel@vger.kernel.org
Message-id: <3F5752B0.2090506@mbda.fr>
Organization: MBDA
MIME-version: 1.0
Content-type: text/plain
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr-fr, fr
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4)
 Gecko/20030612
References: <20030904104245.GA1823@leto2.endorphin.org>
X-OriginalArrivalTime: 04 Sep 2003 14:54:49.0970 (UTC)
 FILETIME=[7D810520:01C372F4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fruhwirth clemens wrote:

> Hi!
> 
> I recently posted a module for twofish which implements the algorithm in
> assembler (http://marc.theaimsgroup.com/?l=linux-kernel&m=106210815132365&w=2)
> 
> Unfortunately the assembler used is masm. I'd like to change that. Netwide
> Assembler (nasm) is the assembler of my choice since it focuses on
> portablity and has a more powerful macro facility (macros are heavily used
> by 2fish_86.asm). But as I'd like to make my work useful (aim for an
> inclusion in the kernel) I noticed that this would be the first module to
> depend on nasm. Everything else uses gas.
>

Check those archive about the boot code rewrite.

http://www.ussg.iu.edu/hypermail/linux/kernel/9908.0/0107.html
http://www.ussg.iu.edu/hypermail/linux/kernel/9908.1/0083.html

http://www.ussg.iu.edu/hypermail/linux/kernel/9907.3/0960.html

-- 
Yann Droneaud <yann.droneaud@mbda.fr>
<ydroneaud@meuh.eu.org> <meuh@tuxfamily.org>

