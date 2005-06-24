Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261978AbVFXG1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261978AbVFXG1p (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 02:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263177AbVFXG1p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 02:27:45 -0400
Received: from [67.137.28.189] ([67.137.28.189]:2962 "EHLO vger")
	by vger.kernel.org with ESMTP id S263178AbVFXG12 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 02:27:28 -0400
Message-ID: <42BB932D.9050808@utah-nac.org>
Date: Thu, 23 Jun 2005 22:59:25 -0600
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Beulich <JBeulich@novell.com>
Cc: Christoph Lameter <christoph@lameter.com>,
       Clyde Griffin <CGRIFFIN@novell.com>,
       "John W. Linville" <linville@tuxdriver.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Novell Linux Kernel Debugger (NLKD)
References: <s2bae938.075@sinclair.provo.novell.com>  <Pine.LNX.4.62.0506231723360.26299@graphe.net>  <20050624003515.GB28077@tuxdriver.com> <42BB510B.5080500@utah-nac.org> <42BBC297020000780001D4A5@emea1-mh.id2.novell.com>
In-Reply-To: <42BBC297020000780001D4A5@emea1-mh.id2.novell.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Beulich wrote:

>>It's a GBD replacement and is not fully open source.
>>    
>>
>
>What is not open source in it ()?
>
>  
>
>>KDB is at present more capable. It has a lot of promise, but it does not 
>>have the all the architectural
>>features necessary to replace either KDB or GDB at present.
>>    
>>
>
>While I never used or saw kdb, I'd be curious about what you immediately saw missing...
>  
>

1. No back trace
2. Doesn't run standalone fully embeded in the kernel
3. Not fully open source (since it's not embeded in the kernel)
4. IA64 doesn't really matter, since IA64 is basically dead anyway
5. No advanced recursive descent parser for conditional breakpoints

Jeff

>Jan
>
>
>  
>

