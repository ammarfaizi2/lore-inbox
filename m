Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136108AbREIKdC>; Wed, 9 May 2001 06:33:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136113AbREIKcx>; Wed, 9 May 2001 06:32:53 -0400
Received: from natpost.webmailer.de ([192.67.198.65]:55268 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S136108AbREIKcj>; Wed, 9 May 2001 06:32:39 -0400
From: Stefan Hoffmeister <lkml.2001@econos.de>
To: Tobias Ringstrom <tori@tellus.mine.nu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, <jwright@penguincomputing.com>,
        <redhat-devel-list@redhat.com>, <linux-kernel@vger.kernel.org>,
        Jeremy Hogan <jhogan@redhat.com>, Mike Vaillancourt <mikev@redhat.com>,
        Philip Pokorny <ppokorny@penguincomputing.com>
Subject: Re: bug in redhat gcc 2.96
Date: Wed, 09 May 2001 12:31:00 +0200
Organization: Econos
Message-ID: <017iftsqpdb9j59cs5vn95mhp8mk59kgjm@4ax.com>
In-Reply-To: <E14xPli-0001qP-00@the-village.bc.nu> <Pine.LNX.4.33.0105091058480.31224-100000@svea.tellus>
In-Reply-To: <Pine.LNX.4.33.0105091058480.31224-100000@svea.tellus>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

: On Wed, 9 May 2001 11:09:14 +0200 (CEST), Tobias Ringstrom wrote:

>On Wed, 9 May 2001, Alan Cox wrote:
>> > Any suggestions for a way to cope with this?  We have a
>> > customer who's system fails due to this.
>>
>> You can build 2.4 quite sanely with egcs-1.1.2 (aka kgcc)
>
>Since there is no kgcc in RH71, 

There is an compat-egcs RPM (on CD2?) that contains kgcc. Took me a while
to find that.
