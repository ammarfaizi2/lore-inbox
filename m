Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261991AbTHTOas (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 10:30:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261994AbTHTOas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 10:30:48 -0400
Received: from moutng.kundenserver.de ([212.227.126.189]:9977 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261991AbTHTOar (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 10:30:47 -0400
Message-ID: <3F438615.2000305@gamic.com>
Date: Wed, 20 Aug 2003 16:30:45 +0200
From: Sergey Spiridonov <spiridonov@gamic.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: how to turn off, or to clear read cache?
References: <3F4360F0.209@gamic.com> <200308201311.h7KDBgL20530@Port.imtp.ilyichevsk.odessa.ua>
In-Reply-To: <200308201311.h7KDBgL20530@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> umount/mount cycle will do it, as well as intentional OOMing the box
> (from non-root account please;)

OOMing doesn't help also, since kernel starts to swap and I have 
performance degradation after. Swithching off the swap is dangerous in 
conjunction with OOMing.

-- 
Best regards, Sergey Spiridonov

