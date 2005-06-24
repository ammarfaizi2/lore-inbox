Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262992AbVFXBpi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262992AbVFXBpi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 21:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262994AbVFXBpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 21:45:38 -0400
Received: from [67.137.28.189] ([67.137.28.189]:64401 "EHLO vger")
	by vger.kernel.org with ESMTP id S262992AbVFXBpP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 21:45:15 -0400
Message-ID: <42BB510B.5080500@utah-nac.org>
Date: Thu, 23 Jun 2005 18:17:15 -0600
From: jmerkey <jmerkey@utah-nac.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "John W. Linville" <linville@tuxdriver.com>
Cc: Christoph Lameter <christoph@lameter.com>,
       Clyde Griffin <CGRIFFIN@novell.com>, linux-kernel@vger.kernel.org,
       Jan Beulich <JBeulich@novell.com>
Subject: Re: Novell Linux Kernel Debugger (NLKD)
References: <s2bae938.075@sinclair.provo.novell.com> <Pine.LNX.4.62.0506231723360.26299@graphe.net> <20050624003515.GB28077@tuxdriver.com>
In-Reply-To: <20050624003515.GB28077@tuxdriver.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I have downloaded and reviewed the code. It's a GBD replacement and is 
not fully open source.
KDB is at present more capable. It has a lot of promise, but it does not 
have the all the architectural
features necessary to replace either KDB or GDB at present.

Jeff

>On Thu, Jun 23, 2005 at 05:24:04PM -0700, Christoph Lameter wrote:
>  
>
>>On Thu, 23 Jun 2005, Clyde Griffin wrote:
>>
>>    
>>
>>>Novell engineering is introducing the Novell Linux Kernel Debugger 
>>>(NLKD) as an open source project intended to provide an enhanced and 
>>>robust debugging experience for Linux kernel developers.
>>>      
>>>
>>Umm... How does this differ from KDB?
>>    
>>
>
>Sounds like it overlaps w/ both KDB and KGDB...still, the question
>stands...
>
>John
>  
>

