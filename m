Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262839AbTHZTTS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 15:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262846AbTHZTTS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 15:19:18 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:27820 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262839AbTHZTTO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 15:19:14 -0400
Message-ID: <3F4BB1C5.7090605@namesys.com>
Date: Tue, 26 Aug 2003 23:15:17 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alex Zarochentsev <zam@namesys.com>
CC: Steven Cole <elenstev@mesatop.com>, Oleg Drokin <green@namesys.com>,
       reiserfs-dev@namesys.com, reiserfs-list@namesys.com,
       linux-kernel@vger.kernel.org, demidov <demidov@namesys.com>,
       god@namesys.com
Subject: Re: reiser4 snapshot for August 26th.
References: <20030826102233.GA14647@namesys.com> <1061922037.1670.3.camel@spc9.esa.lanl.gov> <3F4BA9E9.4090108@namesys.com> <20030826184114.GP5448@backtop.namesys.com>
In-Reply-To: <20030826184114.GP5448@backtop.namesys.com>
X-Enigmail-Version: 0.76.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alex Zarochentsev wrote:

>On Tue, Aug 26, 2003 at 10:41:45PM +0400, Hans Reiser wrote:
>  
>
>>Mr. Demidov, if you put code that does not compile into our tree you 
>>need to make the config option for it be invisible.
>>    
>>
>
>There is such an option already, CONFIG_REISER4_FS_SYSCALL, 
>seems it is off by default.
>
>  
>
Off != invisible

-- 
Hans


