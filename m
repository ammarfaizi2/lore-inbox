Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261790AbTD3JSJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 05:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbTD3JSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 05:18:09 -0400
Received: from [203.116.36.98] ([203.116.36.98]:32936 "HELO
	mail.bii.a-star.edu.sg") by vger.kernel.org with SMTP
	id S261790AbTD3JSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 05:18:08 -0400
Message-ID: <1209.192.168.122.46.1051695018.squirrel@web.bii.a-star.edu.sg>
Date: Wed, 30 Apr 2003 17:30:18 +0800 (SGT)
Subject: Re: RHAS kernel upgrade?
From: "Yang-Hwee TAN" <tanyh@bii-sg.org>
To: <venom@sns.it>
In-Reply-To: <Pine.LNX.4.43.0304301125360.5028-100000@cibs9.sns.it>
References: <1188.192.168.122.46.1051694168.squirrel@web.bii.a-star.edu.sg>
        <Pine.LNX.4.43.0304301125360.5028-100000@cibs9.sns.it>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

looking at the rhas kernel src rpm, there's alot of patches
made into the kernel, i'm not sure if i use the plain vanilla
kernel tarball would i disable some kernel options and
"cripple" any of the RH's advance server's functionality(s).

has anyone use RHAS in a cluster environment with manual
upgrading of kernel to perhaps 2.4.20, and everything goes
well on the AS functionalities/add-ons?

-yanghwee

>
> why it should not?
>
> if you do not need any particular driver not included into vanilla
> kernel...
>
> On Wed, 30 Apr 2003, Yang-Hwee TAN wrote:
>
>> Date: Wed, 30 Apr 2003 17:16:08 +0800 (SGT)
>> From: Yang-Hwee TAN <tanyh@bii.a-star.edu.sg>
>> To: linux-kernel@vger.kernel.org
>> Subject: RHAS kernel upgrade?
>>
>> hi,
>>
>> i'm wondering is it good build if i upgrade my
>> RedHat Advance Server kernel via the use of the
>> kernel tarball downloaded from kernel.org?
>>
>>
>> --
>> Yang-Hwee TAN
>> Systems Engineer (Cluster Computing)
>> http://www.bii.a-star.edu.sg/~tanyh
>>
>> Bioinformatics Institute
>> http://www.bii.a-star.edu.sg
>> Tel: +65 6874-1271
>>
>>
>> -
>> To unsubscribe from this list: send the line "unsubscribe
>> linux-kernel" in the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/



