Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262579AbSJBUtB>; Wed, 2 Oct 2002 16:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbSJBUtB>; Wed, 2 Oct 2002 16:49:01 -0400
Received: from ppp77-4-71.miem.edu.ru ([80.250.162.71]:54912 "EHLO null.ru")
	by vger.kernel.org with ESMTP id <S262579AbSJBUtA>;
	Wed, 2 Oct 2002 16:49:00 -0400
Message-ID: <3D9B5C7F.1000001@yahoo.com>
Date: Thu, 03 Oct 2002 00:52:15 +0400
From: Stas Sergeev <stssppnn@yahoo.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: miero@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] default file permission for vfat
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

Miroslav Rudisin wrote:
> The attached patch change default permission of files on [v]fatfs. 
> Default RWX have no utilization. This patch remove exec flag. 
Thank you very much!
Since the "noexec" option was broken, this
patch is extremely usefull.
I would like to see it included, but, as I
don't know the details, I pretend to say nothing
except that it is very usefull for me.

