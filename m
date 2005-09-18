Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbVIRWM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbVIRWM3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Sep 2005 18:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbVIRWM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Sep 2005 18:12:29 -0400
Received: from rwcrmhc13.comcast.net ([216.148.227.118]:11179 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932227AbVIRWM2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Sep 2005 18:12:28 -0400
Message-ID: <432DE645.6090308@namesys.com>
Date: Sun, 18 Sep 2005 15:12:21 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Denis Vlasenko <vda@ilport.com.ua>,
       Alexander Zarochentcev <zam@namesys.com>
CC: LKML <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: I request inclusion of reiser4 in the mainline kernel
References: <432AFB44.9060707@namesys.com> <200509171416.21047.vda@ilport.com.ua>
In-Reply-To: <200509171416.21047.vda@ilport.com.ua>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:

>On Friday 16 September 2005 20:05, Hans Reiser wrote:
>  
>
>>All objections have now been addressed so far as I can discern.
>>    
>>
>
>Random observation:
>
>You can declare functions even if you never use them.
>Thus here you can avoid using #if/#endif:
>
>#if defined(REISER4_DEBUG) || defined(REISER4_DEBUG_MODIFY) || defined(REISER4_DEBUG_OUTPUT)
>int znode_is_loaded(const znode * node /* znode to query */ );
>#endif
>
>--
>vda
>
>
>  
>
thanks.

zam, please address this.
