Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbULCQRZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbULCQRZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 11:17:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262366AbULCQRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 11:17:25 -0500
Received: from fire.osdl.org ([65.172.181.4]:25528 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S262357AbULCQRP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 11:17:15 -0500
Message-ID: <41B08F2C.3020105@osdl.org>
Date: Fri, 03 Dec 2004 08:07:08 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Ross <chris@tebibyte.org>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: oom goodness Re: 2.6.10-rc2-mm4
References: <20041130095045.090de5ea.akpm@osdl.org> <41B036DB.5060502@tebibyte.org>
In-Reply-To: <41B036DB.5060502@tebibyte.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Ross wrote:
> 
> Andrew Morton escreveu:
> 
>> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm4/ 
>>
> 
> 
> I hope I'm not tempting providence by reporting that this is the first 
> unpatched kernel in a while that seems free of the oom killer problems 
> I've been seeing. It's successfully handled all the usual trouble spots 
> (compiling umlsim, cron.daily etc.) on my 64MB machine without killing 
> off a single random process.

for some definition of "unpatched"... :)

-- 
~Randy
