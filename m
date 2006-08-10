Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161244AbWHJNDn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161244AbWHJNDn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 09:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161243AbWHJNDn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 09:03:43 -0400
Received: from mailout1.vmware.com ([65.113.40.130]:50180 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1161237AbWHJNDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 09:03:42 -0400
Message-ID: <44DB2EAD.8070302@vmware.com>
Date: Thu, 10 Aug 2006 06:03:41 -0700
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
Cc: virtualization@lists.osdl.org, Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>
Subject: Re: [PATCH] paravirt.h
References: <1155202505.18420.5.camel@localhost.localdomain> <20060810103012.GA2356@muc.de> <1155207946.18420.18.camel@localhost.localdomain> <200608101331.19954.ak@muc.de>
In-Reply-To: <200608101331.19954.ak@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> Hmm, i still see a lot of them (and __volatile too) 
>
> Also maybe it's my mail client, but the resulting patch seems to be also full of
> MIME damage:
>
>  EXTRA_AFLAGS   :=3D -traditional
>   

Hmm.  I don't see that here. 
