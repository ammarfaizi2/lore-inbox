Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932374AbVI2XwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932374AbVI2XwM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVI2XwM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:52:12 -0400
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:41873 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932374AbVI2XwM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:52:12 -0400
Message-ID: <433C7E19.5040307@namesys.com>
Date: Thu, 29 Sep 2005 16:51:53 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Alexandre Buisse <alexandre.buisse@ens-lyon.fr>,
       linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: 2.6.14-rc2-mm2
References: <20050929143732.59d22569.akpm@osdl.org>	<433C60B1.8080003@ens-lyon.fr> <20050929155646.757339a9.akpm@osdl.org>
In-Reply-To: <20050929155646.757339a9.akpm@osdl.org>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems to fail on some machines and setups, and work on others,
notably the ones we use.;-)

We will fix it tomorrow and send it in.

Andrew Morton wrote:

>Alexandre Buisse <alexandre.buisse@ens-lyon.fr> wrote:
>  
>
>>
>>Hi Andrew,
>>
>>just wanting to report that reiser4 as a module was not compiling
>>anymore. It failed with the following message :
>>
>>    
>>

