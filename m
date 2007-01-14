Return-Path: <linux-kernel-owner+w=401wt.eu-S1751138AbXANHi2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751138AbXANHi2 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 02:38:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751142AbXANHi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 02:38:27 -0500
Received: from nf-out-0910.google.com ([64.233.182.189]:55921 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbXANHi0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 02:38:26 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=a54Ix44v8BCTnL0KJK+9vw35Iv1YkMMbs/KcoNSQJEwi8Kd9jMN7mtpF64pL0GLyzpWMA0g1YHTGvlwEKcr9/GDYFkER8eR6rwcJZHWa829nOeNRlOiBbmJQ53URvXNwJywN11vqT2+43Ft+8CWM0smmB0z709Pzw5gRTOkJt4E=
Message-ID: <b6a2187b0701132338t6840551coe83b83d461723198@mail.gmail.com>
Date: Sun, 14 Jan 2007 15:38:24 +0800
From: "Jeff Chua" <jeff.chua.linux@gmail.com>
To: "Jan Engelhardt" <jengelh@linux01.gwdg.de>
Subject: Re: Linux v2.6.20-rc5
Cc: "Adrian Bunk" <bunk@stusta.de>, "Andrew Morton" <akpm@osdl.org>,
       "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0701131402000.19787@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.LNX.4.64.0701121424520.11200@woody.osdl.org>
	 <20070112142645.29a7ebe3.akpm@osdl.org>
	 <20070113050143.GF7469@stusta.de>
	 <Pine.LNX.4.61.0701131402000.19787@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/07, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> On Jan 13 2007 06:01, Adrian Bunk wrote:
> >On Fri, Jan 12, 2007 at 02:26:45PM -0800, Andrew Morton wrote:

> *cough*vmware*cough*

setting CONFIG_PARAVIRT=y will return in ...

       vmmon.ko module unknown symbol paravirt_ops

Without it, vmware runs run. Any fix?
