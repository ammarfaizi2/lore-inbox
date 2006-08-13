Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWHMONt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWHMONt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 10:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWHMONt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 10:13:49 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:32428 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751255AbWHMONs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 10:13:48 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NDFflJuhxx8O3TonBlWW8ta/VlQ9StYi2Df2ZPqIn6lKmxqfsj6WzHNavCTpz/HbclEDfJRd50OD2BjQTbKb/cHHv9coTjiiknX96AW9cnDsl8VALA9LKdw4RbFJWCQp5wPvvAH2/ZMf9D/tYHunRhRH6q1CkI7NBoI0y885WC0=
Message-ID: <b0943d9e0608130713j1e4a8836i943d31011169cf05@mail.gmail.com>
Date: Sun, 13 Aug 2006 15:13:47 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: [PATCH 2.6.18-rc4 00/10] Kernel memory leak detector 0.9
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <6bffcb0e0608130459k1c7e142esbfc2439badf323bd@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060812215857.17709.79502.stgit@localhost.localdomain>
	 <6bffcb0e0608130459k1c7e142esbfc2439badf323bd@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal,

On 13/08/06, Michal Piotrowski <michal.k.k.piotrowski@gmail.com> wrote:
> Can you look at this?
>
=======================================================
> [ INFO: possible circular locking dependency detected ]

Thanks for this. Did you get this with the previous version of
kmemleak (0.8) or you just tried it now.

I'll have a look.

-- 
Catalin
