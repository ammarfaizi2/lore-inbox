Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264648AbUD1GGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264648AbUD1GGw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 02:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264647AbUD1GGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 02:06:51 -0400
Received: from mail.fastclick.com ([205.180.85.17]:65162 "EHLO
	mail.fastclick.net") by vger.kernel.org with ESMTP id S264648AbUD1GGs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 02:06:48 -0400
Message-ID: <408F49EF.6020508@fastclick.com>
Date: Tue, 27 Apr 2004 23:06:39 -0700
From: "Brett E." <brettspamacct@fastclick.com>
Reply-To: brettspamacct@fastclick.com
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: busterbcook@yahoo.com
CC: Kernel Mailing List <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: pdflush eating a lot of CPU on heavy NFS I/O
References: <Pine.LNX.4.58.0404280009300.28371@ozma.hauschen>
In-Reply-To: <Pine.LNX.4.58.0404280009300.28371@ozma.hauschen>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brent Cook wrote:

>  This didn't seem to be a problem with 2.6.5 or 2.4. Is there something I
> can do to control pdflush or to provide more information?
> 
> Thanks
>  - Brent
> 
Yes regarding controlling pdflush, I don't know about providing pdflush 
information. From Andrew Morton(Thanks Andrew!):

The tunables in /proc/sys/vm are documented in 
Documentation/filesystems/proc.txt.



