Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262703AbTDASBt>; Tue, 1 Apr 2003 13:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262704AbTDASBt>; Tue, 1 Apr 2003 13:01:49 -0500
Received: from adsl-67-114-192-42.dsl.pltn13.pacbell.net ([67.114.192.42]:4637
	"EHLO mx1.corp.rackable.com") by vger.kernel.org with ESMTP
	id <S262703AbTDASBs>; Tue, 1 Apr 2003 13:01:48 -0500
Message-ID: <3E89D649.90800@rackable.com>
Date: Tue, 01 Apr 2003 10:11:21 -0800
From: Samuel Flory <sflory@rackable.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: File system corruption under 2.4.21-pre5-ac1
References: <3E88EA79.2060301@rackable.com> <112820000.1049138786@caspian.scsiguy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 01 Apr 2003 18:13:07.0736 (UTC) FILETIME=[58AF0980:01C2F87A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin T. Gibbs wrote:

>>    I'm seeing filesystem corruption on a number of intel SE7501wv2's 
>> under
>> 2.4.21-pre5-ac1.  The systems are running Cerberus (ctcs).  They fail 
>> the
>> kcompile, and memtst tests.
>
>
> Are you running the aic79xx driver version embedded in that kernel 
> version
> or the latest from my site?
>
> http://people.FreeBSD.org/~gibbs/linux/SRC/ 


  That seems to have fixed the issues.  All of the systems burned in 
over night with out issue.   Thanks.


-- 
There is no such thing as obsolete hardware.
Merely hardware that other people don't want.
(The Second Rule of Hardware Acquisition)
Sam Flory  <sflory@rackable.com>



