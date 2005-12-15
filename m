Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750832AbVLORmd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVLORmd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 12:42:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbVLORmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 12:42:33 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:29279 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750832AbVLORmc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 12:42:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Kpicf0XvS+85KtSttcBEc+06/SEH3dHuYqL5HoaJtZjmeC/fk1pDAH3yeGcAdzQAjazAs2dERirae8SRbVaQTJDqGqKAP0mBi/kHx7jk1QqaD3h4GRfVPMmQKHHTMESyZb2D1hL07bdIw0S2hF0VXwhVzbP0X3Ifrc4A64mNMws=
Message-ID: <6bffcb0e0512150942p4eb155e6y@mail.gmail.com>
Date: Thu, 15 Dec 2005 18:42:31 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Martin Bligh <mbligh@mbligh.org>
Subject: Re: 2.6.15-rc5-mm3 (new build failure)
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
In-Reply-To: <43A1A95D.10800@mbligh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43A1A95D.10800@mbligh.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 15/12/05, Martin Bligh <mbligh@mbligh.org> wrote:
> New build failure since -mm2:
> Config is
> http://ftp.kernel.org/pub/linux/kernel/people/mbligh/config/abat/elm3b67
>
> I'm guessing it was using gcc 2.95.4, though not sure.
>

Yes. The same thing happen when I run "make CC=gcc-2.95".

Regards,
Michal Piotrowski
