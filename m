Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750989AbVLGMgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750989AbVLGMgT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 07:36:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750988AbVLGMgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 07:36:18 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:41695 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750987AbVLGMgS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 07:36:18 -0500
Message-ID: <4396D814.5070809@aitel.hist.no>
Date: Wed, 07 Dec 2005 13:39:48 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
CC: Michael Poole <mdpoole@troilus.org>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux in a binary world... a doomsday scenario
References: <1133779953.9356.9.camel@laptopd505.fenrus.org> <200512051826.06703.andrew@walrond.org> <1133817575.11280.18.camel@localhost.localdomain> <1133817888.9356.78.camel@laptopd505.fenrus.org> <1133819684.11280.38.camel@localhost.localdomain> <4394D396.1020102@am.sony.com> <20051206041215.GC26602@kroah.com> <87iru2c0zc.fsf@graviton.dyn.troilus.org> <20051206172153.GB22502@kvack.org>
In-Reply-To: <20051206172153.GB22502@kvack.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin LaHaise wrote:

>On Mon, Dec 05, 2005 at 11:18:15PM -0500, Michael Poole wrote:
>  
>
>>Besides, if the act of linking is what makes the derivative work,
>>there is no problem: The GPL allows a user to make any modifications
>>or combinations or derivatives whatsoever, and only imposes
>>requirements when the result is distributed.  The linking of the two
>>works occurs only on the end user's machine.
>>    
>>
>
>But if it's a module, it's probably been compiled against kernel headers.  
>Last time I checked, header files were covered by the GPL unless explicitly 
>placed under a more permissive license.  How do you use something like 
>spinlocks without compiling in GPL code to a module?
>  
>
They can always claim that reverse engineering works both ways.
Linux spinlocks can be reverse engineered, or they can search
the mailing list archives for detailed explanations. :-/

Helge Hafting
