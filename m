Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967202AbWKYV2j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967202AbWKYV2j (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 16:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967212AbWKYV2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 16:28:39 -0500
Received: from ms-smtp-01.rdc-kc.rr.com ([24.94.166.115]:58356 "EHLO
	ms-smtp-01.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S967202AbWKYV2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 16:28:39 -0500
Message-ID: <4568B56C.8080601@lwfinger.net>
Date: Sat, 25 Nov 2006 15:28:12 -0600
From: Larry Finger <Larry.Finger@lwfinger.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Benoit Boissinot <bboissin@gmail.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.19-rc5-mm1 progression
References: <456718F6.8040902@lwfinger.net> <40f323d00611240836q6bcf7374gd47c7a97d1d4f8e3@mail.gmail.com> <20061125112437.3d46eff4.akpm@osdl.org>
In-Reply-To: <20061125112437.3d46eff4.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Fri, 24 Nov 2006 17:36:27 +0100
> "Benoit Boissinot" <bboissin@gmail.com> wrote:
> 
>> On 11/24/06, Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>> Is there the equivalent of 'git bisect' for the -mmX kernels?
>>>
>> http://www.zip.com.au/~akpm/linux/patches/stuff/bisecting-mm-trees.txt
>>
> 
> Please take the time to do that.  Yours is an interesting report - I'm not
> aware of anything in there which was expected to cause a change of this
> mature.
> 

I am in the process of isolating the patch. I was already a user of quilt so that part of the 
learning process was no problem.

Larry

