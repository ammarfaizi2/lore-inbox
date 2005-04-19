Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVDSVpZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVDSVpZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 17:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261671AbVDSVpZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 17:45:25 -0400
Received: from alog0252.analogic.com ([208.224.222.28]:16544 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261267AbVDSVpU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 17:45:20 -0400
Date: Tue, 19 Apr 2005 17:44:12 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Chris Friesen <cfriesen@nortel.com>
cc: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>,
       Karel Kulhavy <clock@twibright.com>, linux-kernel@vger.kernel.org
Subject: Re: GPL violation by CorAccess?
In-Reply-To: <42656319.6090703@nortel.com>
Message-ID: <Pine.LNX.4.61.0504191741190.19956@chaos.analogic.com>
References: <20050419175743.GA8339@beton.cybernet.src>
 <20050419182529.GT17865@csclub.uwaterloo.ca> <Pine.LNX.4.61.0504191516080.18402@chaos.analogic.com>
 <42656319.6090703@nortel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Apr 2005, Chris Friesen wrote:

> Richard B. Johnson wrote:
>>
>> Violation? They proudly reply in their article in
>>     http://www.linuxdevices.com
>> that they use Linux, that they embedded a version
>> of Red Hat, etc.
>>
>> It's likely that they didn't modify anything in the kernel and
>> just used some stripped-down C-libraries to make everything fit.
>
> Right.  They're distributing products licensed under the GPL, so
> sections 3-a and 3-b of the GPL apply.
>
> Thus they can either a) accompany it with the source code, or b)
> accompany it with a written offer to give any third party a copy of the
> source code.
>
> Chris

No. Accompany it with a written offer to __provide__ the source
code for any GPL stuff they used (like the kernel or drivers).
Anything at the application-level is NOT covered by the GPL.
They do not have to give away their trade-secrets.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
