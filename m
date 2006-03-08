Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932211AbWCHUng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932211AbWCHUng (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 15:43:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932463AbWCHUnf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 15:43:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43949 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932211AbWCHUne (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 15:43:34 -0500
Message-ID: <440F4130.5040703@redhat.com>
Date: Wed, 08 Mar 2006 15:40:16 -0500
From: William Cohen <wcohen@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: eranian@hpl.hp.com
CC: linux-kernel@vger.kernel.org, perfmon@napali.hpl.hp.com,
       perfctr-devel@lists.sourceforge.net, linux-ia64@vger.kernel.org
Subject: Re: 2.6.16-rc5 perfmon2 new code base + libpfm with Montecito support
References: <20060308155311.GD13168@frankl.hpl.hp.com>
In-Reply-To: <20060308155311.GD13168@frankl.hpl.hp.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Eranian wrote:
> Hello,
> 
> I have released another version of the perfmon new base package.
> This release is relative to 2.6.16-rc5

Hello Stephane,

Is there any thoughts on how perfmon2 is going to work with xen enabled 
kernels or processors that support virtualization?

-Will
