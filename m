Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265890AbUFISJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265890AbUFISJc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 14:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265887AbUFISJb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 14:09:31 -0400
Received: from sccrmhc11.comcast.net ([204.127.202.55]:4862 "EHLO
	sccrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S265886AbUFISJR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 14:09:17 -0400
Message-ID: <40C75273.7020508@namesys.com>
Date: Wed, 09 Jun 2004 11:09:55 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: Chris Mason <mason@suse.com>, reiserfs-dev@namesys.com,
       linux-kernel@vger.kernel.org
Subject: Re: [STACK] >3k call path in reiserfs
References: <20040609122226.GE21168@wohnheim.fh-wedel.de> <1086784264.10973.236.camel@watt.suse.com> <1086800028.10973.258.camel@watt.suse.com> <40C74388.20301@namesys.com> <20040609172843.GB2950@wohnheim.fh-wedel.de>
In-Reply-To: <20040609172843.GB2950@wohnheim.fh-wedel.de>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:

>On Wed, 9 June 2004 10:06:16 -0700, Hans Reiser wrote:
>  
>
>>Can you give me some background on whether this is causing real problems 
>>for real users?
>>    
>>
>
>It's not [yet].  This was done with statical analysis and keeping a
>little extra room for safety.  If you prefer to wait for real bug
>reports, go ahead...
>
>...but note that my signature ai has proven it's merits once again...
>  
>
what is your signature ai?

>Jörn
>
>  
>
Unless it is really necessary, or a small code change, I would prefer to 
spend our cycles worrying about this in reiser4, because code changes in 
V3 are to be avoided if possible.

I am open to arguments that it is really necessary.
