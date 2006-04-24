Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751275AbWDXVD4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWDXVD4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:03:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751279AbWDXVDz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:03:55 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:2566 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S1751275AbWDXVDz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:03:55 -0400
Message-ID: <444D3D32.1010104@argo.co.il>
Date: Tue, 25 Apr 2006 00:03:46 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Gary Poppitz <poppitzg@iomega.com>, linux-kernel@vger.kernel.org
Subject: Re: Compiling C++ modules
References: <B9FF2DE8-2FE8-4FE1-8720-22FE7B923CF8@iomega.com> <1145911546.1635.54.camel@localhost.localdomain>
In-Reply-To: <1145911546.1635.54.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Apr 2006 21:03:52.0490 (UTC) FILETIME=[9746B0A0:01C667E2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> There are a few anti C++ bigots around too, but the kernel choice of C
> was based both on rational choices and experimentation early on with the
> C++ compiler.
>   
Times have changed, though. The C++ compiler is much better now, and the 
recent slew of error handling bugs shows that C is a very unsafe language.

I think it's easy to show that the equivalent C++ code would be shorter, 
faster, and safer.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

