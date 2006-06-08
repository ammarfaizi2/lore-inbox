Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWFHL2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWFHL2k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jun 2006 07:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbWFHL2k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jun 2006 07:28:40 -0400
Received: from wr-out-0506.google.com ([64.233.184.226]:49775 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932259AbWFHL2j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jun 2006 07:28:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y72yk75x7dX0kj9qnQpfqItIxSipVbu6GcfCBBCl+nXXt+xtoOqt+dE6UGUyjL9+DDRvLgP9LMJWJvtxiI/6gu4xD/mscBy24zuea84B94qfSvkHs7+APlxhEifAPdd+yFSpOCCBUHE0c7NEHSpL3efHzpyNeFGsf/s2TdelqNk=
Message-ID: <6bffcb0e0606080428g4a224fa0vb9c903d6fef2df69@mail.gmail.com>
Date: Thu, 8 Jun 2006 13:28:37 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: 2.6.17-rc6-rt1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060607211455.GA6132@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060607211455.GA6132@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/06, Ingo Molnar <mingo@elte.hu> wrote:
> i have released the 2.6.17-rc6-rt1 tree, which can be downloaded from
> the usual place:
>
>    http://redhat.com/~mingo/realtime-preempt/
>

I can't unload ip_conntrack module.

Here is strace http://www.stardust.webpages.pl/files/rt/2.6.17-rc6-rt1/ip_conntrack_strace

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
