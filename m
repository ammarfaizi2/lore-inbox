Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264658AbUHGXVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264658AbUHGXVe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 19:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264640AbUHGXVE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 19:21:04 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:53720 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264643AbUHGXUu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 19:20:50 -0400
Message-ID: <411563D0.1050608@namesys.com>
Date: Sat, 07 Aug 2004 16:20:48 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephen Smalley <sds@epoch.ncsc.mil>
CC: andrea@cpushare.com, lkml <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: secure computing for 2.6.7
References: <20040704173903.GE7281@dualathlon.random>	 <40EC4E96.9090800@namesys.com> <1091536845.7645.60.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1091536845.7645.60.camel@moss-spartans.epoch.ncsc.mil>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley wrote:

>On Wed, 2004-07-07 at 15:27, Hans Reiser wrote:
>  
>
>>Am I right to think that this could complement nicely our plans 
>>described at www.namesys.com/blackbox_security.html
>>    
>>
>
>Hi Hans,
>
>Out of curiosity, what do you think that this proposal will achieve that
>cannot already be done via SELinux policy?  SELinux policy can already
>express access rules based not only on the executable and user, but even
>the entire call chain that led to a given executable.
>
>  
>
Where do you store the access rules?  With the executable?   How do you 
automate their determination?
