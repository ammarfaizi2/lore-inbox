Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbVDTQ0c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbVDTQ0c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Apr 2005 12:26:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVDTQ0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Apr 2005 12:26:32 -0400
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:47371 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id S261711AbVDTQ0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Apr 2005 12:26:30 -0400
Message-ID: <4266732A.6050508@lougher.demon.co.uk>
Date: Wed, 20 Apr 2005 16:20:10 +0100
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041012)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove some usesless casts
References: <20050420065500.GA24213@wohnheim.fh-wedel.de>
In-Reply-To: <20050420065500.GA24213@wohnheim.fh-wedel.de>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> Squashfs is extremely cast-happy.  This patch makes it less so.
> 
> Jörn
> 

Hi,

Thanks for the patch.  Unnecessary casts were one of the things 
mentioned when I submitted the patches to the LKML, and therefore I 
suspect most of them have been already fixed (but I will apply your 
patch to check).

I will send revised patches to the LKML soon, most of the issues raised 
by the comments have been fixed, the current delay is being caused by 
the 4GB limit re-work.

Regards

Phillip

