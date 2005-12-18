Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932665AbVLRCV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932665AbVLRCV2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 21:21:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932662AbVLRCV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 21:21:28 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:23062 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932665AbVLRCV1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 21:21:27 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sonqkxR2nXMHSB2Hv+Ewe5kwFAL9xRb80dZabl5iZPT1w3BZlC+yGsDn4o66rQy2XQ7gfwaaPMSytN6nQp4eB/YxNKpAQvoWPJgkcaVo63heswdgYoACrC9WBLH0UFFdFip41Txbq1ORz6+g+s5FdbZptbi/+qbIr9uAN63KmB0=
Message-ID: <758a2bbf0512171821j5be863c1x8d6b35e67f5f1fea@mail.gmail.com>
Date: Sat, 17 Dec 2005 18:21:26 -0800
From: Vijay Sampath <vsampath@gmail.com>
To: gcoady@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MTD (kernel 2.4.32): kernel stuck in tight loop occasionally on flash access
In-Reply-To: <758a2bbf0512171759i35df21e7t8a1b00f72c362614@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <02DAE179D5CEED4C992055C823ED90FF8ACE8E@ex1>
	 <758a2bbf0512171759i35df21e7t8a1b00f72c362614@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >         Something is wrong here?  Your patch should not alter dontdiff.
>
> It didn't. 2.4 kernel doesn't have dontdiff, so I had to download it.
> But I only downloaded to one of the directories, hence the messed up
> output. Maybe dontdiff should have "dontdiff" as one of the files not
> to diff! :)

Sorry for another mail, but please let me know if I should resubmit
the patch without the dontdiff problem.
