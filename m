Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265874AbUAFXhX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 18:37:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266015AbUAFXhX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 18:37:23 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:6324 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S265874AbUAFXhV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 18:37:21 -0500
Message-ID: <3FFB46B0.9060101@namesys.com>
Date: Wed, 07 Jan 2004 02:37:20 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Drokin <green@linuxhacker.ru>
CC: linux-kernel@vger.kernel.org, mfedyk@matchmail.com,
       Jesper Juhl <juhl-lkml@dif.dk>
Subject: Re: Suspected bug infilesystems (UFS,ADFS,BEFS,BFS,ReiserFS) related
 to sector_t being unsigned, advice requested
References: <Pine.LNX.4.56.0401052343350.7407@jju_lnx.backbone.dif.dk> <3FFA7717.7080808@namesys.com> <Pine.LNX.4.56.0401061218320.7945@jju_lnx.backbone.dif.dk> <20040106174650.GD1882@matchmail.com> <200401062135.i06LZAOY005429@car.linuxhacker.ru>
In-Reply-To: <200401062135.i06LZAOY005429@car.linuxhacker.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:

>
>
>This code was never executing anyway.
>
>  
>
Oleg, I thought you ran a script for finding dead code last fall or 
summer?  Any idea why it didn't find this and gcc did?  Or did you only 
run it on reiser4?

-- 
Hans


