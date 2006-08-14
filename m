Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932298AbWHNOgQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932298AbWHNOgQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 10:36:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbWHNOgQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 10:36:16 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:58332 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932298AbWHNOgQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 10:36:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jdbrMBe5SzHpNR8POl8k1a+hnKikRrXEi8+G7pGx8nAgBoO2j11/J0kDtLaoXQpJbCltXc3C0Lk+cJ/3FxS8QZXJW8MYAhUggAoCyjNZJLiklOECtSney9LafokPBoHHRCk/S53ADM0UDo/3YOzS+MebvI0sGsMdqg+4wlkltsA=
Message-ID: <d120d5000608140736w4bc04e69ycbea97e5817ce584@mail.gmail.com>
Date: Mon, 14 Aug 2006 10:36:14 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Luke Sharkey" <lukesharkey@hotmail.co.uk>
Subject: Re: Touchpad problems with latest kernels
Cc: linux-kernel@vger.kernel.org, "Dave Jones" <davej@redhat.com>
In-Reply-To: <BAY114-F2C4913B499BE3113C8E9BFA4E0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <BAY114-F2C4913B499BE3113C8E9BFA4E0@phx.gbl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/06, Luke Sharkey <lukesharkey@hotmail.co.uk> wrote:
> Dear Sir,
>
> I am emailing regarding some problems I have been having with the touchpad
> on my laptop (a hp pavilion dv5046ea  running Fedora Core 5 x86_64).
> [ Here are the specifications for my laptop:
> http://h10010.www1.hp.com/wwpc/uk/en/ho/WF06b/21675-38187-38191-38191-38191-12319008-69074479.html]
>
>
> Support for my touchpad seems to have gotten worse rather than better in
> successive kernels from 2054 onwards.
>
> While on 2054 it generally works fine, On the latest kernels (2154, 2174
> etc.)  I have only to e.g. open a konqueror window for the onscreen pointer
> to start going funny, and jerking about (As happens on computers with v. low
> RAM).  I know its not a RAM problem, as a) everything else works fine, there
> is no slow down of any of the programs I run, only problems with the mouse
> and b) I have just upgraded from 512 MB of RAM to 1 GB.
>
> If I plug in a mouse, the pointer works fine.  Though I would happily use a
> mouse, this is often inconvenient on a laptop.
>

What kind of touchpad is this? Are you using synaptics X driver or
standard mouse driver? Also I am not quire sure what 2054 or 2154 is.
Can you please try vanilla kernels from kernel.org?

Dave, is there a place where one can see contents of a given RH kernel
(without downloadig and unpacking SRPM)?

-- 
Dmitry
