Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262687AbVCaAdQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262687AbVCaAdQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 19:33:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262688AbVCaAao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 19:30:44 -0500
Received: from www.webclippings.com ([38.144.36.11]:50848 "EHLO
	allresearch.com") by vger.kernel.org with ESMTP id S262687AbVCaA3o
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 19:29:44 -0500
Message-ID: <424B446D.6080500@allresearch.com>
Date: Wed, 30 Mar 2005 16:29:33 -0800
From: Noah Silverman <noah@allresearch.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Joel Becker <Joel.Becker@oracle.com>, linux-kernel@vger.kernel.org
Subject: Re: Fw: Hangcheck problem
References: <20050330141248.45aada63.akpm@osdl.org> <20050331000006.GB31163@ca-server1.us.oracle.com>
In-Reply-To: <20050331000006.GB31163@ca-server1.us.oracle.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joel,

I'm not specifically loading hangcheck anywhere.  I just installed
slackware and mysql on the box.  Nothing special.

-N


Joel Becker wrote:

>>Date: Wed, 30 Mar 2005 12:45:43 -0800
>>From: Noah Silverman <noah@allresearch.com>
>>To: linux-kernel@vger.kernel.org
>>Subject: Hangcheck problem
>>
>>I'm been experiencing a weird problem....
>>
>>I get endlessly repeated hangcheck errors in my syslog with no explanation:
>>
>>Mar 30 12:41:43 db kernel: Hangcheck: hangcheck value past margin!
>>    
>>
>
>	A couple questions.  First, why are you loading hangcheck?  Do
>you have an environment where it matters?  That said, it would seem that
>hangcheck is detecting a system hang.  Does your system often pause?  Is
>it a laptop that is being put to sleep?
>
>  
>
>>Eventually, after a few weeks, the box will hang.  It is pingable, but I
>>can't ssh or connect to any servcie.
>>    
>>
>
>	I don't know if the problem is even related to hangcheck.  If
>you are seeing pauses elsewhere, then it could be that hangcheck is
>catching the pauses "properly".
>
>Joel
>
>  
>
