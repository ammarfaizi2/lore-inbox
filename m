Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751139AbWGUUZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbWGUUZI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 16:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWGUUZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 16:25:08 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:19870 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751139AbWGUUZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 16:25:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ic2nFaWVe0gtbFayPFYTo0UPCaWY0yp3C576yWS9PQU8IO3xZPr9kAfcy2yjdZIEMDnR3DqHzgja76yj5NEhwAgUCZVwhYktHadPMlq+FpBDcWmHDmiT5ghOEdwbFmZMPn5QpCALwXAYmikV2mQa3wJ7ipoWg+xO5fA+mpaQqCQ=
Message-ID: <7f45d9390607211325n402ddaadm2290871934cf8ae@mail.gmail.com>
Date: Fri, 21 Jul 2006 14:25:05 -0600
From: "Shaun Jackman" <sjackman@gmail.com>
Reply-To: "Shaun Jackman" <sjackman@gmail.com>
To: "Dmitry Torokhov" <dtor_core@ameritech.net>
Subject: Re: [PATCH] elo: Support non-pressure-sensitive ELO touchscreens
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <200607210210.37923.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <7f45d9390602241045p45aec8auaf881a4dab00c17a@mail.gmail.com>
	 <7f45d9390603280709u5eea134ejb0aaacdd49984a92@mail.gmail.com>
	 <7f45d9390607191434g6261b6f8pf1c9a9688770d95f@mail.gmail.com>
	 <200607210210.37923.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/21/06, Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > Can this patch adding support for non-pressure-sensitive ELO
> > touchscreens be applied? Any comments?
> >
>
> Shaun,
>
> I still think that we need to query the touchscreen andd act based on
> its reported features. Could you please tell me if the patch below works?
>
> Thanks!

Hello Dmitry,

I'm afraid I'm off the project that used the ELO touch screen for now.
Since the patch I posted was working reliably for me, I wanted to try
another attempt at pushing it up so that it didn't just whither on the
vine. I may come back to the project that used the ELO touch screen at
some point, but that might be a few months away. If/when I do, I'll
certainly test your patch. Sorry that I can't do so now.

Cheers,
Shaun
