Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751901AbWIRUHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751901AbWIRUHY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 16:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751899AbWIRUHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 16:07:24 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:58057 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751901AbWIRUHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 16:07:23 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=H+U6bN/5ILTLsRO4WIkTLBgfizhbBaqHKJM2i3+EQmQkP0B2vxMFcnXmfof1EyNQ+O7mkafQaesiBT+r5OM3A5Sot5zuqEMKEn3+n+DVzfZWGKEVas8nx/u7aVZwouIIJlnCVQKbWX5h1P3cqEJwi6EcpL0kiniJLuMucA2gw9Y=
Message-ID: <acd2a5930609181307y793242f3sef5d59487bc7dad@mail.gmail.com>
Date: Tue, 19 Sep 2006 00:07:22 +0400
From: "Vitaly Wool" <vitalywool@gmail.com>
To: "Eugeny S. Mints" <eugeny.mints@gmail.com>
Subject: Re: [linux-pm] [PATCH] PowerOP, PowerOP Core, 1/2
Cc: "Pavel Machek" <pavel@ucw.cz>, "pm list" <linux-pm@lists.osdl.org>,
       "kernel list" <linux-kernel@vger.kernel.org>
In-Reply-To: <450EFA4C.1070004@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45096933.4070405@gmail.com> <20060918104437.GA4973@elf.ucw.cz>
	 <450E83DC.4050503@gmail.com> <450EFA4C.1070004@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eugeny,

On 9/18/06, Eugeny S. Mints <eugeny.mints@gmail.com> wrote:

> With such approach a policy manger may compare operating points at runtime and
> should not rely on compile time knowledge about what name corresponds to  what
> set of power parameter values. It uses name as a handle.

I suggest that you supply a meaningful yet simple example for SMP case.

Thanks,
   Vitaly
