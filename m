Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030325AbVKPSEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbVKPSEV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 13:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030335AbVKPSEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 13:04:21 -0500
Received: from c-67-177-35-222.hsd1.ut.comcast.net ([67.177.35.222]:896 "EHLO
	vger.utah-nac.org") by vger.kernel.org with ESMTP id S1030325AbVKPSEU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 13:04:20 -0500
Message-ID: <437B60C6.7040308@wolfmountaingroup.com>
Date: Wed, 16 Nov 2005 09:39:34 -0700
From: "Jeffrey V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: davids@webmaster.com
Cc: "Jeff V. Merkey" <jmerkey@utah-nac.org>, alex@alexfisher.me.uk,
       linux-kernel@vger.kernel.org
Subject: Re: Would I be violating the GPL?
References: <MDEHLPKNGKAHNMBLJOLKIEDBIBAB.davids@webmaster.com>
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKIEDBIBAB.davids@webmaster.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Schwartz wrote:

>>If you even take 2 minutes to actually inspect the NVIDIA video
>>driver sources
>>(extract the .run file with --extract-only, and cd to usr/src/nv)
>>you'll find
>>the "glue" which is provided as source, but not under the GPL,
>>does indeed
>>#include kernel headers at compile time.
>>
>>It does not distribute them, however, but it is completely nonsensical to
>>class this as having "no dependency". It has a compile time and runtime
>>dependency on the current kernel. What driver wouldn't?
>>    
>>
>
>	If I write source code that includes "stdio.h", I can do whatever I want
>with that source code, and I'm not bound by the license of any particular
>file that happens to be called "stdio.h". On the other hand, if I compile
>that source code including *your* "stdio.h" file, the resulting compiled
>output is likely a derived work of your file.
>
>	So the source code is not a derivative work of any GPL'd files. The
>compiled driver may be, precisely because it contains bits and pieces of the
>header files.
>
>	DS
>
>
>
>  
>
Correct.

Jeff
