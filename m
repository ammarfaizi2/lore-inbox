Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946510AbWKJL4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946510AbWKJL4L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 06:56:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424394AbWKJL4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 06:56:11 -0500
Received: from adsl02.metz.linbox.com ([62.212.120.90]:6869 "EHLO
	fbxmetz.linbox.com") by vger.kernel.org with ESMTP id S1424391AbWKJL4K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 06:56:10 -0500
Message-ID: <455468D8.7080609@linbox.com>
Date: Fri, 10 Nov 2006 12:56:08 +0100
From: Ludovic Drolez <ludovic.drolez@linbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20060628 Debian/1.7.8-1sarge7.1
X-Accept-Language: fr, en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.18.2: cannot compile with gcc 3.0.4
References: <45545C1B.4040204@linbox.com> <9a8748490611100328w75ccf2e8uc1121a80e68242d8@mail.gmail.com>
In-Reply-To: <9a8748490611100328w75ccf2e8uc1121a80e68242d8@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> If you had bothered to read Documentation/Changes then you would have
> seen that the current minimal required gcc version is 3.2 :

Ok sorry, I didn't see the change between 2.6.15 and 2.6.16.
Maybe a test should be added in linux/compiler-gcc3.h, to have the same 
warning as with gcc 2.xx ?

Cheers,

-- 
Ludovic DROLEZ                              Linbox / Free&ALter Soft
www.linbox.com www.linbox.org	              tel: +33 3 87 50 87 90
152 rue de Grigy - Technopole Metz 2000                   57070 METZ
