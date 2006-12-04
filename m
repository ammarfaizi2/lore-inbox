Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936168AbWLDLvq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936168AbWLDLvq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 06:51:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936175AbWLDLvq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 06:51:46 -0500
Received: from nf-out-0910.google.com ([64.233.182.191]:28153 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S936168AbWLDLvp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 06:51:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=f/aFaUPrGP25WBPTPMAm/ZRfitpWaRnSrrgFT7+Qr2/KC+p/10LxjP9J4iUmEMPpxl9fZLCS00XxJeP/6Gq1wvQKjEpNLoi89iwNY69jmInnmIi/pE6uz5tQ7XLyKp/p2jyA07T2Sl0JQ8wWWhmktwvZr9qT7cIK6PwrCtIJPPE=
Message-ID: <24c1515f0612040351p6056101frc12db8eb86063213@mail.gmail.com>
Date: Mon, 4 Dec 2006 13:51:44 +0200
From: "Janne Karhunen" <janne.karhunen@gmail.com>
To: MrUmunhum@popdial.com
Subject: Re: Mounting NFS root FS
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4571CE06.4040800@popdial.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <4571CE06.4040800@popdial.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/2/06, William Estrada <MrUmunhum@popdial.com> wrote:
> Hi guys,
>
>   I have been trying to make FC5's kernel do a boot
> with an NFS root file system.  I see the support is in the
> kernel(?).

Is this really properly possible (with read/write access and
locking in place)? AFAIK NFS client lock state data seems
to require persistent storage .. ?


-- 
// Janne
