Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266181AbUJNPYZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266181AbUJNPYZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 11:24:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266221AbUJNPYZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 11:24:25 -0400
Received: from fire.osdl.org ([65.172.181.4]:63695 "EHLO fire-1.osdl.org")
	by vger.kernel.org with ESMTP id S266181AbUJNPYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 11:24:23 -0400
Message-ID: <416E982D.4030909@osdl.org>
Date: Thu, 14 Oct 2004 08:15:57 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
Organization: OSDL
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Haroldo Gamal <haroldo.gamal@silexonline.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Submitting patches for unmaintained areas (Solaris x86 UFS bug)
References: <c461c0d10410130406714fafe3@mail.gmail.com> <416D1D6F.4080508@silexonline.org> <416D442C.5070305@osdl.org> <416E600E.5010209@silexonline.org>
In-Reply-To: <416E600E.5010209@silexonline.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haroldo Gamal wrote:
> I have mailed Mr. Urban Widmark ans answered the appropriate bugzilla 
> bug - https://bugzilla.samba.org/show_bug.cgi?id=999. No response until 
> now.
> 
> Maybe my patches do not apply for some reason, but I've got no response. 
> I would like to get some feedback.

Hm, if he is unresponsive, you can try any of (in no special order):

a.  VFS maintainer (Al Viro)
b.  2.6 maintainer (Andrew Morton)
c.  linux-fsdevel@vger.kernel.org
d.  samba@samba.org


> Randy.Dunlap wrote:
> 
>> Haroldo Gamal wrote:
>>
>>> I've done have done the same with 
>>> http://bugzilla.kernel.org/show_bug.cgi?id=3330 and I have the same 
>>> question!
>>>
>>> Where do I go from now?
>>
>>
>>
>> Have you tried contacting the SMBfs maintainer?
>> from the MAINTAINERS file:
>>
>> SMB FILESYSTEM
>> P:    Urban Widmark
>> M:    urban@teststation.com
>> W:    http://samba.org/
>> L:    samba@samba.org
>> S:    Maintained


-- 
~Randy
