Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754391AbWKHHPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754391AbWKHHPY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Nov 2006 02:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754393AbWKHHPY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Nov 2006 02:15:24 -0500
Received: from mis011-2.exch011.intermedia.net ([64.78.21.129]:39851 "EHLO
	mis011-2.exch011.intermedia.net") by vger.kernel.org with ESMTP
	id S1754391AbWKHHPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Nov 2006 02:15:24 -0500
Message-ID: <455183EA.2020405@qumranet.com>
Date: Wed, 08 Nov 2006 09:14:50 +0200
From: Avi Kivity <avi@qumranet.com>
User-Agent: Thunderbird 1.5.0.7 (X11/20061027)
MIME-Version: 1.0
To: Roland Dreier <rdreier@cisco.com>
CC: Andrew Morton <akpm@osdl.org>, kvm-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/14] KVM: Kernel-based Virtual Machine (v4)
References: <454E4941.7000108@qumranet.com>	<20061107204440.090450ea.akpm@osdl.org> <adafycuh77b.fsf@cisco.com>
In-Reply-To: <adafycuh77b.fsf@cisco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Nov 2006 07:15:23.0654 (UTC) FILETIME=[A84AC260:01C70305]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland Dreier wrote:
>  > That's gas 2.16.1.  I assume it needs some super-new binutils.
>  > 
>  > I'm not sure what to do about this.  What's the minimum version?
>
> According to http://kvm.sourceforge.net/howto.html :
>     A recent enough binutils (>= 2.16.91.0.2) for vmx instruction support
>   

Either that or a bunch of ugly .byte macros.


-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

