Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965125AbWGKETs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbWGKETs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 00:19:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965129AbWGKETs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 00:19:48 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:57392 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S965125AbWGKETr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 00:19:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hPdFWIbsIMFLAlQTzNr3NJMAGuOCWX+7gb4mXm6cntYM+hXA3Npwcaoc2dWAa+8wODRp4WvzRM3dvya85h9a30LbFXx1opQ5NROyz9PG+re3bHkOQovWtbzLYMhzhnCWdNqbnVlWxt8PmvUCfju9m4b7a44CLdmj3T1peCjNn5A=
Message-ID: <489ecd0c0607102119r7fe924c6s289df2de65f4faeb@mail.gmail.com>
Date: Tue, 11 Jul 2006 12:19:46 +0800
From: "Luke Yang" <luke.adi@gmail.com>
To: "David Miller" <davem@davemloft.net>
Subject: Re: [PATCH] Fix an inproper alignment accessing in irda protocol stack
Cc: samuel@sortiz.org, akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <20060710.202956.83858417.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <489ecd0c0606131929l5311bdb9g1e903904f0d8fb2b@mail.gmail.com>
	 <20060617.221435.48805608.davem@davemloft.net>
	 <489ecd0c0607101912t4225e551sa608faa769f09064@mail.gmail.com>
	 <20060710.202956.83858417.davem@davemloft.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/06, David Miller <davem@davemloft.net> wrote:
> From: "Luke Yang" <luke.adi@gmail.com>
> Date: Tue, 11 Jul 2006 10:12:41 +0800
>
> >   There is another same unaligend issue in irda stack to be fixed:
> >
> > Signed-off-by: Luke Yang <luke.adi@gmail.com>
>
> Your patch is corrupted by your email client and cannot be applied
> cleanly to the current kernel sources.
>
> This is the second time around I've had to ask you to correct this
> kind of problem with your submissions.  Consider this my last and
> final warning.
>
> A lot of my time is wasted when patches are improperly submitted.

 I am sorry. I have resend the whole patch for this issue in right
format. And as gmail keeps convert tabs to spaces. I attached the
right format patch as a attachment. So you can read the patch in my
mail and use the attached one to check in. This method has been
discussed and acceptted.
>


-- 
Best regards,
Luke Yang
luke.adi@gmail.com
