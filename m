Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932610AbWKEJrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932610AbWKEJrQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 04:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932611AbWKEJrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 04:47:16 -0500
Received: from nf-out-0910.google.com ([64.233.182.185]:11111 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932610AbWKEJrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 04:47:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cNRlHVHDPpKBkVues+RS+m130w25AAsMF5/N2p7XpkZRdcPWxmeN1nvprTlPXAwO4wE5dgWDiAXIS0PL/ibNcLyOqm80vFYSp5HCmZxRQqRqRudDIsfvzJmieEzJgcw4Qx/qGHsaidYG2QWr4Vba+jVGdElqPDZdyn28KpqWBAs=
Message-ID: <653402b90611050147x5af94b50s46a5f107f29031b@mail.gmail.com>
Date: Sun, 5 Nov 2006 09:47:13 +0000
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "xp newbie" <xp_newbie@yahoo.com>
Subject: Re: How do I know whether a specific driver being used?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061105033026.53019.qmail@web38401.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061105033026.53019.qmail@web38401.mail.mud.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/06, xp newbie <xp_newbie@yahoo.com> wrote:
> I am using an Ubuntu system with kernel 2.6.15-27-686.
>
> I am trying to find out whether I need to compile
> myself a driver for my Promise FastTrack 378
> controller as described here:
>
> http://www.linuxquestions.org/questions/showthread.php?t=362780
>

This mailing list is about kernel development, this is not the right
place to ask that. Anyway, 3rd party kernels, patches, drivers... are
not covered here.

> But before doing so, I prefer to know in advance (if
> possible) whether this module is already included in
> (and perhaps used by) the kernel.
>

Did you browse menuconfig?

> [...]
