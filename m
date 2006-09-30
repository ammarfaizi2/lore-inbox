Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWI3Scm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWI3Scm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 14:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751372AbWI3Scm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 14:32:42 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:2609 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751370AbWI3Scl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 14:32:41 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O+sndXpyW67vvzKjhsOQpPm37cyIjk9hLPTomq7Mj5J0SeMkE0qMUNFwRMwjwFxNPEu4wQZH7VCXqg3gKr1PA5Jq+ylvEz8W2Wd1re6sSCOrqB4jdkEnOWXo6aq2M3GnERGRHKOm4oK4lkFMbZIhmhtETCoiJWwPwzYOJ3F47iA=
Message-ID: <4727185d0609301132y6a6899eapa05d37c52d2eaab@mail.gmail.com>
Date: Sat, 30 Sep 2006 20:32:40 +0200
From: "Vincent Legoll" <vincent.legoll@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [PATCH] off-by-one in kernel command line option parsing
Cc: "Vincent Legoll" <legoll@online.fr>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
In-Reply-To: <200609302025.17903.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <451EB56C.9020105@online.fr> <200609302025.17903.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/30/06, Andi Kleen <ak@suse.de> wrote:
> That code is already gone in the latest tree.

OK, I fumbled with git and checked a not-so-recent
snapshot. Sorry for the noise.

-- 
Vincent Legoll
