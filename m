Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316959AbSGNR0O>; Sun, 14 Jul 2002 13:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316961AbSGNR0N>; Sun, 14 Jul 2002 13:26:13 -0400
Received: from twinlark.arctic.org ([208.44.199.239]:41643 "EHLO
	twinlark.arctic.org") by vger.kernel.org with ESMTP
	id <S316959AbSGNR0M>; Sun, 14 Jul 2002 13:26:12 -0400
Date: Sun, 14 Jul 2002 10:29:04 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: "David S. Miller" <davem@redhat.com>
cc: davidsen@tmr.com, <alan@lxorguk.ukuu.org.uk>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BUG?] unwanted proxy arp in 2.4.19-pre10
In-Reply-To: <20020713.205930.101495830.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0207141026440.4252-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 13 Jul 2002, David S. Miller wrote:

>
> You have to use specific source-routing settings in conjuntion with
> enabling arp_filter in order for arp_filter to have any effect.
>
> This is a FAQ.

a couple google queries yielded no answer to this faq... is there a posted
example somewhere?

is the default behaviour of use to anyone?  this question comes up like
every other month.

-dean

