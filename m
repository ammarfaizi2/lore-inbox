Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132147AbRAZQE1>; Fri, 26 Jan 2001 11:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135286AbRAZQES>; Fri, 26 Jan 2001 11:04:18 -0500
Received: from [213.38.169.194] ([213.38.169.194]:59918 "EHLO
	proxy.herefordshire.gov.uk") by vger.kernel.org with ESMTP
	id <S132924AbRAZQEC>; Fri, 26 Jan 2001 11:04:02 -0500
Message-ID: <AFE36742FF57D411862500508BDE8DD055F6@mail.herefordshire.gov.uk>
From: "Randal, Phil" <prandal@herefordshire.gov.uk>
To: "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: RE: hotmail not dealing with ECN
Date: Fri, 26 Jan 2001 16:04:03 -0000
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Sutherland wrote:

> Except you can't retry without ECN, because DaveM wants to do 
> a Microsoft and force ECN on everyone, whether they like it
> or not. If ECN is so wonderful, why doesn't anybody actually
> WANT to use it anyway?

And there's the rub.  Whether ECN is wonderful or not, attempting
to force it on everyone, whether they like it or not, whether
(for whatever reason) they are able to upgrade their firewalls
to handle ECN appropriately or not, is a recipe for a "Great
Linux Public Relations Disaster".

Because if we do try to force it, the response which will come
back won't be "Linux is wonderful, it conforms to the standards".
It will be "Linux sucks, we can't connect to xyz.com with it (or
we can't connect because to xyz.com they run it)".

We may be right, "they" may be wrong, but in the real world
arrogance rarely wins anyone friends.

Just my 2p worth,

Phil

(speaking for myself and not my employer)

---------------------------------------------
Phil Randal
Network Engineer
Herefordshire Council
Hereford, UK
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
