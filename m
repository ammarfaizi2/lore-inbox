Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932185AbVKWTdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932185AbVKWTdi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 14:33:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932198AbVKWTdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 14:33:37 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:62451 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932185AbVKWTdh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 14:33:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=lYccIhRiF4ZO96i8Bz5SXNIoma+40N97npDRImyE7k8CFQwjT7rMQJmU8c+7PA72MSFAosb7lvORL7Fi8ackOIQKIc9wR5b29GE4+X0yMx85A4NW9fEP888DwegFo8QObxnSi1lBIO5pp+BOyxDgr2kf5b++aWI42GeE/spUlIU=
Message-ID: <cbec11ac0511231133m63bec4ddi455fa769dd22906b@mail.gmail.com>
Date: Thu, 24 Nov 2005 08:33:36 +1300
From: Ian McDonald <imcdnzl@gmail.com>
To: Marc Koschewski <marc@osknowledge.org>
Subject: Re: 2.6.15-rc2-mm1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20051123175045.GA6760@stiffy.osknowledge.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051123033550.00d6a6e8.akpm@osdl.org>
	 <20051123175045.GA6760@stiffy.osknowledge.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/05, Marc Koschewski <marc@osknowledge.org> wrote:
> Just booted into 2.6.15-rc2-mm1. The 'mouse problem' (as reported earlier) still
> persists, moreover, some stuff's now really not gonna work anymore. I logged in
> via gdm once and rebooted.
>
> Ragards,
>         Marc
>

Mouse problem is userspace. See bug 340202 on the Debian site.

Ian
--
Ian McDonald
http://wand.net.nz/~iam4
WAND Network Research Group
University of Waikato
New Zealand
