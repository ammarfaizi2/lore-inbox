Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270253AbRHRQgZ>; Sat, 18 Aug 2001 12:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270252AbRHRQgF>; Sat, 18 Aug 2001 12:36:05 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:18956 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S270249AbRHRQf7>;
	Sat, 18 Aug 2001 12:35:59 -0400
Message-Id: <200108172239.CAA01781@mops.inr.ac.ru>
Subject: Re: connect() does not return ETIMEDOUT
To: Alessandro.Ren@vantcom.NET (Alessandro Motter Ren)
Date: Sat, 18 Aug 2001 02:39:50 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <734932D6EA60D511A13600508BDE72485244B6@slentms1.vantcom.net> from "Alessandro Motter Ren" at Aug 17, 1 05:45:06 pm
From: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> 	I had to set connect to do non blocking connections in order to
> avoid this problem,

Sorry, what "this" problem? :-)

You have made something surely not related to the subject.

* non-blocking connect succeeds instantly, of course, like blocking one. 
* error never appears in this case, because connection is succesful.

It was original observation.

Alexey
