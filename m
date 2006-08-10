Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422654AbWHJRja@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422654AbWHJRja (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 13:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422658AbWHJRja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 13:39:30 -0400
Received: from wx-out-0506.google.com ([66.249.82.233]:53787 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1422656AbWHJRj2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 13:39:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UbNiwAE0pnLo/3O5nyvN2JxIV32iAsmL6utUitH7uBtp3Qy6CXVTO3+sZzQif7W3x6EpyCVV+RA1bL5VKqrtBvhvzLBz/gxP7RZRbdZwb0A4NdeIplZXituUw4jDRRZX8F5xPPVyXFxJrmDGI0SdcBvRCcWfqoFDaXJembTsQY0=
Message-ID: <1defaf580608101039kca604c6x1220d78ad5c50717@mail.gmail.com>
Date: Thu, 10 Aug 2006 19:39:26 +0200
From: "=?ISO-8859-1?Q?H=E5vard_Skinnemoen?=" <hskinnemoen@gmail.com>
To: "Andi Kleen" <ak@suse.de>
Subject: Re: [PATCH 7/14] Generic ioremap_page_range: i386 conversion
Cc: "Haavard Skinnemoen" <hskinnemoen@atmel.com>,
       "Andrew Morton" <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
In-Reply-To: <200608101853.47003.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <1155225826761-git-send-email-hskinnemoen@atmel.com>
	 <11552258272265-git-send-email-hskinnemoen@atmel.com>
	 <11552258271169-git-send-email-hskinnemoen@atmel.com>
	 <200608101853.47003.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/10/06, Andi Kleen <ak@suse.de> wrote:
> On Thursday 10 August 2006 18:03, Haavard Skinnemoen wrote:
> > From: Andi Kleen <ak@suse.de>
>
> Hmm? I didn't write this patch.

No, the original patch didn't have that line. I must have messed up
something with git-send-email...

Håvard
