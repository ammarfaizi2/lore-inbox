Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262546AbVAUVuE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262546AbVAUVuE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 16:50:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262554AbVAUVtI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 16:49:08 -0500
Received: from lakermmtao12.cox.net ([68.230.240.27]:32154 "EHLO
	lakermmtao12.cox.net") by vger.kernel.org with ESMTP
	id S262550AbVAUVro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 16:47:44 -0500
In-Reply-To: <20050121192640.GA5479@redhat.com>
References: <41F11C66.5000707@sgi.com> <20050121192640.GA5479@redhat.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <14752AEE-6BF6-11D9-A93E-000393ACC76E@mac.com>
Content-Transfer-Encoding: 7bit
Cc: Prarit Bhargava <prarit@sgi.com>, linux-kernel@vger.kernel.org,
       vojtech@suse.cz
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH][RFC]: Clean up resource allocation in i8042 driver
Date: Fri, 21 Jan 2005 16:47:43 -0500
To: Dave Jones <davej@redhat.com>
X-Mailer: Apple Mail (2.619)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 21, 2005, at 14:26, Dave Jones wrote:
>> -                       printk(KERN_ERR "i8042.c: i8042 controller 
>> self
>> test timeout.\n");
> wordwrapped patch.

Err, it showed up fine for me.  I suspect your mail client or server is
mangling emails.

>>                }
>>
>>                }
> I doubt these }'s should line up, broken indentation ?

Likewise, looks fine to me.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


