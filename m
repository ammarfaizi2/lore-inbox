Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759253AbWLAJVY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759253AbWLAJVY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 04:21:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759266AbWLAJVY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 04:21:24 -0500
Received: from galaxy.systems.pipex.net ([62.241.162.31]:31682 "EHLO
	galaxy.systems.pipex.net") by vger.kernel.org with ESMTP
	id S1759253AbWLAJVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 04:21:23 -0500
Date: Fri, 1 Dec 2006 09:21:36 +0000 (GMT)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: tigran@ginsburg.homenet
To: Arjan van de Ven <arjan@infradead.org>
Cc: Hua Zhong <hzhong@gmail.com>, "'Adrian Bunk'" <bunk@stusta.de>,
       linux-kernel@vger.kernel.org
Subject: RE: [2.6 patch] Tigran Aivazian: remove bouncing email addresses
In-Reply-To: <1164964119.3233.56.camel@laptopd505.fenrus.org>
Message-ID: <Pine.LNX.4.61.0612010919170.29499@ginsburg.homenet>
References: <00e401c7150e$061da500$6721100a@nuitysystems.com>
 <1164964119.3233.56.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arjan,

On Fri, 1 Dec 2006, Arjan van de Ven wrote:

> On Thu, 2006-11-30 at 22:00 -0800, Hua Zhong wrote:
>> I am curious, what's the point?
>>
>> These email addresses serve a "historical" purpose: they tell when the contribution was made,  what the author's email addresses
>> were at that point.
>
>
> .. and which company owns the copyright.

VERITAS doesn't own any copyright of the microcode driver because I wrote 
it _before_ I joined VERITAS.

> Lets not remove historical email addresses. Just make sure there's a
> current one in MODULE_AUTHOR / MAINTAINERS.

I agree, so I should have included in the patch the change to 
MODULE_AUTHOR (in both microcode and bfs).

Or maybe MODULE_AUTHOR shouldn't contain the email address, if the module 
is mentioned in the MAINTAINERS which does contain it? Why repeat the data 
and so have to remember to maintain it?

Kind regards
Tigran
