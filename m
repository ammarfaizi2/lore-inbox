Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262661AbUCJPbv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 10:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbUCJPbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 10:31:51 -0500
Received: from [195.23.16.24] ([195.23.16.24]:36282 "EHLO
	bipbip.comserver-pie.com") by vger.kernel.org with ESMTP
	id S262665AbUCJPah (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 10:30:37 -0500
Message-ID: <404F3467.4050204@grupopie.com>
Date: Wed, 10 Mar 2004 15:29:43 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: GrupoPIE
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4.1) Gecko/20020508 Netscape6/6.2.3
X-Accept-Language: en-us
MIME-Version: 1.0
To: Romain Lievin <romain@lievin.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question: user-land filesystem & vfs
References: <20040310095147.GA18197@lievin.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Romain Lievin wrote:

> Hi,
> 
> is there a way to create a file system in user mode (without patching the kernel) ?
> 
> I saw that a project called LUFS (Linux User File System) exists at lufs.sf.net but it's not finished. Are there any other ones ?
> 
> Thanks, Romain
> 


You can also take a look at FUSE:


http://sourceforge.net/projects/avf

I haven't tried it myself, so I'm just pointing you to it :)

-- 
Paulo Marques - www.grupopie.com
"In a world without walls and fences who needs windows and gates?"

