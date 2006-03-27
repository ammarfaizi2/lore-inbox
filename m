Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751110AbWC0WS5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751110AbWC0WS5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 17:18:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWC0WS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 17:18:57 -0500
Received: from mail12.syd.optusnet.com.au ([211.29.132.193]:29634 "EHLO
	mail12.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751110AbWC0WS4 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 17:18:56 -0500
From: Con Kolivas <kernel@kolivas.org>
To: "=?iso-8859-1?q?Andr=E9_Goddard?= Rosa" <andre.goddard@gmail.com>
Subject: Re: [ck] Re: swap prefetching merge plans
Date: Tue, 28 Mar 2006 09:19:18 +1100
User-Agent: KMail/1.8.3
Cc: "Mike Galbraith" <efault@gmx.de>, "Andrew Morton" <akpm@osdl.org>,
       "Nick Piggin" <nickpiggin@yahoo.com.au>,
       "Jan Engelhardt" <jengelh@linux01.gwdg.de>, ck@vds.kolivas.org,
       linux-kernel@vger.kernel.org
References: <20060322205305.0604f49b.akpm@osdl.org> <200603261934.44552.kernel@kolivas.org> <b8bf37780603270737l7c2acb7etdd5c53b3af2eea84@mail.gmail.com>
In-Reply-To: <b8bf37780603270737l7c2acb7etdd5c53b3af2eea84@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200603280919.19154.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Mar 2006 02:37 am, André Goddard Rosa wrote:
> @Con: Is it possible to patch staircase to address this issue as Mike
> did with the stock kernel, so I can see the testcase suceeding?
> Perhaps changing a little the interactivity detection algorithm
> (disabling fairness a little)?

I have code for it already and have been holding off putting it in for a long 
time. This report has renewed my interest in pursuing it.

> I would like to test any patches to improve this situation on staircase
> too.

Thanks. You've always been very helpful in that regard and I appreciate it.

> I would like to see more cooperation on both of you, as you are trying 
> to solve the same problems as I can see.
>
> Please keep walking in the same direction and try to help each other. :)
> Thank you both for your effort, it is very apreciated,

I'll try to.

Cheers,
Con
