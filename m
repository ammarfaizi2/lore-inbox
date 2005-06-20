Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261221AbVFTMUN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbVFTMUN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 08:20:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261225AbVFTMUN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 08:20:13 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:65446 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261221AbVFTMUI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 08:20:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=c/E5j6AyrRaSdmrtNS46cw3g050MVeFYLA5Zn24dMeeIQLnwSLNYmWmZekDajyPQ0mDEVswLotI+leu+nNm1EFyPJTBld3RZ3Nnven+DFs9dU8P0/V2eBJcXjlrUX+aOVaRGXbmldHI2j/nW3eF6I5vc2NMrWoMnTyHxoowhNKg=
Message-ID: <f2176eb805062005201c96510a@mail.gmail.com>
Date: Mon, 20 Jun 2005 20:20:06 +0800
From: Paradise <paradyse@gmail.com>
Reply-To: Paradise <paradyse@gmail.com>
To: linux-kernel@vger.kernel.org,
       Debian Users List <debian-user@lists.debian.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-mm1 cannot build nvidia driver?
In-Reply-To: <f2176eb805062004557fc7b9ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <f2176eb805062004557fc7b9ac@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

seems un/register_ioctl32_conversion is removed from 2.6.12-mm1..
any patch for nvidia kernel driver?

On 6/20/05, Paradise <paradyse@gmail.com> wrote:
> Hi all,
> 
> I cannot build the nvidia with 2.6.12-mm1, error is:
> nvidia: Unknown symbol register_ioctl32_conversion
> nvidia: Unknown symbol unregister_ioctl32_conversion
> 
> Nvidia driver 7174.
> --
> Regards,
> Paradise
> 
> 
> 


-- 
Regards,
Paradise
