Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262473AbVCVFY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262473AbVCVFY0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 00:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262420AbVCVFV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 00:21:59 -0500
Received: from wproxy.gmail.com ([64.233.184.195]:54833 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262364AbVCVFQq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 00:16:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:references;
        b=CH+vvbOlMN59EnPyqiZN9b0vaJpeSkKOTiPy3SEhdVLM6qVEThUg16zoIOzCbdQLSd2GpED+sKtTtQ+KcVgWv978twgsYYoBDQYPJe/s8SgBoOxSrkuRTIGzHDWQHRAVAhzQw5D4N/NHwYDGjXwJZEvd1KGs/AzgrLp8BIpTngI=
Message-ID: <493984f05032121161fb99d8e@mail.gmail.com>
Date: Tue, 22 Mar 2005 06:16:42 +0100
From: Christian Henz <christian.henz@gmail.com>
Reply-To: Christian Henz <christian.henz@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-mm2 + Radeon crash
In-Reply-To: <20050321154332.0ca3e153.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_196_21502101.1111468602290"
References: <493984f050309121212541d8@mail.gmail.com>
	 <20050321154332.0ca3e153.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

------=_Part_196_21502101.1111468602290
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 21 Mar 2005 15:43:32 -0800, Andrew Morton <akpm@osdl.org> wrote:
> Christian Henz <christian.henz@gmail.com> wrote:
> >
> > Hi,
> >
> > I wanted to try 2.6.11-mm2 for the low latency/realtime lsm stuff and
> > I've run into a severe
> > problem.
> 
> Christian, some fixes have bene made in this area.  Could you please test
> 2.6.12-rc1-mm1?
> 

I've only tried once so far and again it immediately rebooted after
running startx. I will try later today to catch that condition where
only X crashes but the XFree68.log gets written.

cheers,
Christian

------=_Part_196_21502101.1111468602290
Content-Type: application/gzip; name="dmesg-2.6.12-rc1-mm1-1.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="dmesg-2.6.12-rc1-mm1-1.gz"

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
------=_Part_196_21502101.1111468602290--
