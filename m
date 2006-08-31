Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751082AbWHaHW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbWHaHW7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 03:22:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbWHaHW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 03:22:58 -0400
Received: from gw.goop.org ([64.81.55.164]:20688 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751070AbWHaHW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 03:22:58 -0400
Message-ID: <44F68E4F.60408@goop.org>
Date: Thu, 31 Aug 2006 00:22:55 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>,
       Zachary Amsden <zach@vmware.com>, Jan Beulich <jbeulich@novell.com>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 5/8] Fix places where using %gs changes the usermode ABI.
References: <20060830235201.106319215@goop.org> <20060831000514.954578791@goop.org> <200608310911.20206.ak@suse.de>
In-Reply-To: <200608310911.20206.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> [...] So did you check that ESP, EIP, EFLAGS now come out correctly again? 
> (e.g. do gdb and strace still work?)
>   
Yep.

    J
