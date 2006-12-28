Return-Path: <linux-kernel-owner+w=401wt.eu-S964964AbWL1ITA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964964AbWL1ITA (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 03:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964970AbWL1ITA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 03:19:00 -0500
Received: from il.qumranet.com ([62.219.232.206]:53466 "EHLO il.qumranet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964965AbWL1IS7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 03:18:59 -0500
Message-ID: <45937DE6.2020704@argo.co.il>
Date: Thu, 28 Dec 2006 10:18:46 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: John Freighter <jfreighter@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: OpenSolaris under KVM?
References: <c89a20770612271445q69ce84abv98d3265a1c88bfbe@mail.gmail.com>
In-Reply-To: <c89a20770612271445q69ce84abv98d3265a1c88bfbe@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Freighter wrote:
> Has anybody succeded running OpenSolaris under KVM virtualization?
> Before I download OS install DVD in vain...
>

There was indeed a report (and a patch) from Michael Riepe to that 
effect.  -rc2 should contain that patch.  Please report to kvm-devel if 
it doesn't work.


-- 
error compiling committee.c: too many arguments to function

