Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266454AbUBLO3w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 09:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266457AbUBLO3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 09:29:52 -0500
Received: from gw-nl6.philips.com ([161.85.127.52]:44518 "EHLO
	gw-nl6.philips.com") by vger.kernel.org with ESMTP id S266454AbUBLO3v
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 09:29:51 -0500
Message-ID: <402B8E8E.1010607@basmevissen.nl>
Date: Thu, 12 Feb 2004 15:32:46 +0100
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
Cc: Kyle <kyle@southa.com>, linux-kernel@vger.kernel.org
Subject: Re: ICH5 with 2.6.1 very slow
References: <164601c3ec06$be8bd5a0$b8560a3d@kyle> <40227C20.80404@basmevissen.nl> <167301c3ec0d$4d8508c0$b8560a3d@kyle> <40227D9D.2070704@basmevissen.nl> <168301c3ec0e$24698be0$b8560a3d@kyle> <4023682E.3060809@basmevissen.nl> <001101c3ecf8$b0f50cc0$b8560a3d@kyle> <40274581.4030002@basmevissen.nl> <004501c3f0ae$ecdd2ec0$b8560a3d@kyle> <20040212084110.GB20898@mail.shareable.org>
In-Reply-To: <20040212084110.GB20898@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
>
> Have a look at the thread called "[RFC] IDE 80-core cable detect -
> chipset-specific code to over-ride eighty_ninty_three()".
> 
> It specifically deals with ICH5 and is probably the same problem as
> you're seeing.
> 

Ive already pointed Kyle to that thread. But the udma settings seem to 
be OK.

So my guess now is that this is not just an issue with the driver only.

Regards,

Bas.

