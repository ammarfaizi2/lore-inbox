Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131626AbRDYUNR>; Wed, 25 Apr 2001 16:13:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131638AbRDYUNH>; Wed, 25 Apr 2001 16:13:07 -0400
Received: from sirius-giga.rz.uni-ulm.de ([134.60.246.36]:7072 "EHLO
	mail.rz.uni-ulm.de") by vger.kernel.org with ESMTP
	id <S131626AbRDYUM6> convert rfc822-to-8bit; Wed, 25 Apr 2001 16:12:58 -0400
Date: Wed, 25 Apr 2001 22:12:56 +0200 (MEST)
From: Markus Schaber <markus.schaber@student.uni-ulm.de>
To: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Single user linux
In-Reply-To: <200104251834.OAA04501@smarty.smart.net>
Message-ID: <Pine.SOL.4.33.0104252211380.27266-100000@lyra.rz.uni-ulm.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2001, Rick Hohensee wrote:

> imel96@trustix.co.id wrote:
> > for those who didn't read that patch, i #define capable(),
> > suser(), and fsuser() to 1. the implication is all users
> > will have root capabilities.
>
> How is that not single user?

Every user still has it's own account, means profile etc.


Gruß,
Markus
-- 
| Gluecklich ist, wer vergisst, was nicht aus ihm geworden ist.
+---------------------------------------.     ,---------------->
http://www.uni-ulm.de/~s_mschab/         \   /
mailto:markus.schaber@student.uni-ulm.de  \_/


