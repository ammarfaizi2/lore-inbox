Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261945AbSJZIRO>; Sat, 26 Oct 2002 04:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261950AbSJZIRN>; Sat, 26 Oct 2002 04:17:13 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:27917 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id <S261945AbSJZIRN>; Sat, 26 Oct 2002 04:17:13 -0400
Message-ID: <$33IAFAtClu9EwpX@n-cantrell.demon.co.uk>
Date: Sat, 26 Oct 2002 09:22:05 +0100
To: linux-kernel@vger.kernel.org
From: robert w hall <bobh@n-cantrell.demon.co.uk>
Subject: Re: loadlin with 2.5.?? kernels
References: <m1bs5in1zh.fsf@frodo.biederman.org>
 <5.1.0.14.2.20021020192952.00b95e80@pop.gmx.net>
 <5.1.0.14.2.20021021192410.00b4ffb8@pop.gmx.net>
 <m18z0os1iz.fsf@frodo.biederman.org> <007501c27b37$144cf240$6400a8c0@mikeg>
 <m1bs5in1zh.fsf@frodo.biederman.org>
 <5.1.0.14.2.20021026064044.00b9a310@pop.gmx.net>
 <m13cqtn5cm.fsf@frodo.biederman.org>
In-Reply-To: <m13cqtn5cm.fsf@frodo.biederman.org>
MIME-Version: 1.0
X-Mailer: Turnpike Integrated Version 4.02 U <ZNyPpF8T4habUIG8OkVoLRXKJZ>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <m13cqtn5cm.fsf@frodo.biederman.org>, Eric W. Biederman
<ebiederm@xmission.com> writes
>Mike Galbraith <efault@gmx.de> writes:
>I wonder what the change in 1.6b was....
>
>Eric

IIRC - kernel_cs & kernel_ds are taken at runtime rather than from the
header file (segment.h?).
(because win4lin bumps them up from their old default values)

(Wine went to using a similar trick I think)
this is all from fading memory - but it's in the README for 1.6b I think

Bob

-- 
robert w hall
