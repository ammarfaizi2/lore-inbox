Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264709AbSJOTS4>; Tue, 15 Oct 2002 15:18:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264755AbSJOTS4>; Tue, 15 Oct 2002 15:18:56 -0400
Received: from ithilien.qualcomm.com ([129.46.51.59]:21502 "EHLO
	ithilien.qualcomm.com") by vger.kernel.org with ESMTP
	id <S264709AbSJOTSz>; Tue, 15 Oct 2002 15:18:55 -0400
Message-Id: <5.1.0.14.2.20021015121958.01b4acd8@mail1.qualcomm.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Tue, 15 Oct 2002 12:24:18 -0700
To: "David S. Miller" <davem@redhat.com>
From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
Subject: Re: [RFC] Rename _bh to _softirq
Cc: kuznet@ms2.inr.ac.ru, mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20021015.104423.36363214.davem@redhat.com>
References: <5.1.0.14.2.20021015093146.05eb7738@mail1.qualcomm.com>
 <Pine.LNX.4.44.0210142119300.26635-100000@localhost.localdomain>
 <200210150157.FAA13254@sex.inr.ac.ru>
 <5.1.0.14.2.20021015093146.05eb7738@mail1.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 10:44 AM 10/15/2002 -0700, David S. Miller wrote:
>    From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
>    Date: Tue, 15 Oct 2002 09:34:02 -0700
>
>    But primary interface should be changed IMO.
>
>I totally disagree.
Care to explain why ?

>Keep _bh, it's cool.
But pretty much meaningless. _softirq on the other hand clearly shows what 
it does.
We don't give names to a functions based on the coolness, do we ? ;-)

btw _si would be equally cool.

Max

