Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVFOFPL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVFOFPL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 01:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261494AbVFOFPK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 01:15:10 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:48066 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261493AbVFOFPF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 01:15:05 -0400
Message-ID: <42AFB94D.5010603@colorfullife.com>
Date: Wed, 15 Jun 2005 07:14:53 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jim Grisanzio <jim.grisanzio@sun.com>
CC: Robert Gadsdon <rgadsdon@bayarea.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] optimization for sys_semtimedop() (was: Opening Day for
 OpenSolaris)
References: <42AF12A8.4060007@colorfullife.com>
In-Reply-To: <42AF12A8.4060007@colorfullife.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Robert,

>IANAL, but if this is from 'OpenSolaris sources' then surely it would be 
>incompatible with the GPL?
>
>  
>
The idea is from the OpenSolaris sources, the implementation is 
independant. Actually OpenSolaris doesn't contain an implementation at 
all, it just mentions the idea.

Jim: From my understanding of the CDDL, only a file that "contains any 
part of the Original Software" must be licensed under the CDDL, there 
are no restrictions (except possibly patents, but I assume that even the 
USPTO won't grant a patent on such a trivial idea) on using methods or 
ideas from OpenSolaris in software that uses other licenses.
Is that correct?

--
    Manfred
