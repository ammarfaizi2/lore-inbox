Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030495AbWHXV51@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030495AbWHXV51 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 17:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030494AbWHXV51
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 17:57:27 -0400
Received: from main.gmane.org ([80.91.229.2]:5851 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1030491AbWHXV50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 17:57:26 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [PATCH] boot: small change of halt method
Date: Fri, 25 Aug 2006 00:56:32 +0200
Organization: Palacky University in Olomouc, experimental physics dep.
Message-ID: <44EE2EA0.4060905@flower.upol.cz>
References: <20060824184447.GA3346@windows95> <44EDF923.4030607@zytor.com> <44EE2228.5020807@flower.upol.cz> <44EE192F.3030906@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
Cc: linux-kernel@vger.kernel.org, pingved@gmail.com
X-Gmane-NNTP-Posting-Host: 158.194.192.153
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20060607 Debian/1.7.12-1.2
X-Accept-Language: en
In-Reply-To: <44EE192F.3030906@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Oleg Verych wrote:
> 
>>>
>> Why not to have a reboot here?
>> Testing and getting such errors on my laptop, it needs a power cycle.
>>
> 
> It makes it harder to debug, mostly.
> 

then maybe "panic=timeout" could be applied here ?

-- 
-o--=O`C  /. .\
  #oo'L O      o
<___=E M    ^--

