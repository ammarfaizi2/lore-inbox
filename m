Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265971AbUJNPhR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265971AbUJNPhR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 11:37:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266236AbUJNPhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 11:37:17 -0400
Received: from postino3.roma1.infn.it ([141.108.26.5]:23940 "EHLO
	postino3.roma1.infn.it") by vger.kernel.org with ESMTP
	id S265971AbUJNPhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 11:37:07 -0400
Message-ID: <416E9D1E.8090203@roma1.infn.it>
Date: Thu, 14 Oct 2004 17:37:02 +0200
From: Davide Rossetti <davide.rossetti@roma1.infn.it>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martijn Sipkema <martijn@entmoot.nl>
CC: linux-kernel@vger.kernel.org
Subject: Re: waiting on a condition
References: <02bb01c4b138$8a786f10$161b14ac@boromir>	 <416D49FF.10003@radiantdata.com> <1097701123.4648.13.camel@localhost.localdomain>
In-Reply-To: <1097701123.4648.13.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiVirus: checked by Vexira Milter 1.0.6; VAE 6.28.0.3; VDF 6.28.0.18
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martijn Sipkema wrote:

>On Wed, 2004-10-13 at 17:30, Peter W. Morreale wrote:
>  
>
>>Have you looked at the wait_event() family yet?       Adapting that 
>>methodolgy might
>>suit your needs.
>>    
>>
>
>wait_event() seems to be what I was looking for; I don't really like the
>condition being an argument.
>
>  
>
you may have a look at http://lwn.net/Articles/22913/
it's interesting :)
regards

