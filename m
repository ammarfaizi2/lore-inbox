Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262793AbVDARB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262793AbVDARB6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 12:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbVDARB6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 12:01:58 -0500
Received: from fire.osdl.org ([65.172.181.4]:33160 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262793AbVDARBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 12:01:35 -0500
Message-ID: <424D7E6A.3020608@osdl.org>
Date: Fri, 01 Apr 2005 09:01:30 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Miklos Szeredi <miklos@szeredi.hu>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: build logs for -mm
References: <E1DH7KJ-00023v-00@dorka.pomaz.szeredi.hu> <424C7016.5050404@osdl.org> <E1DHJLZ-00039U-00@dorka.pomaz.szeredi.hu>
In-Reply-To: <E1DHJLZ-00039U-00@dorka.pomaz.szeredi.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi wrote:
>>>do I believe correctly that you do automatic builds of -mm for lots of
>>>architectures?  If yes, is there some place where the output is
>>>available?  This would be useful for fixing warnings.
>>
>>The OSDL PLM tool also does automated builds of all -linus
>>and -mm releases.  2.6.12-rc1-mm4 results are here:
>>
>>http://www.osdl.org/plm-cgi/plm?module=patch_info&patch_id=4352
> 
> 
> Thanks.  I see that for most architectures this only builds a
> defconfig kernel, which is not useful for projects not included in
> defconfig.
> 
> Would it be too much load for the server to handle a full config for
> all archs?

I'm asking about that (I don't do the PLM builds).

-- 
~Randy
