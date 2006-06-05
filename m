Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S1750896AbWFEK1u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750896AbWFEK1u (ORCPT <rfc822;akpm@zip.com.au>);
	Mon, 5 Jun 2006 06:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbWFEK1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jun 2006 06:27:49 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:30112 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1750894AbWFEK1s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jun 2006 06:27:48 -0400
Date: Mon, 5 Jun 2006 12:27:46 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Ben Collins <bcollins@ubuntu.com>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [Updated v3]: How to become a kernel driver maintainer
In-Reply-To: <1149284317.4533.312.camel@grayson>
Message-ID: <Pine.LNX.4.61.0606051218590.31612@yvahk01.tjqt.qr>
References: <1136736455.24378.3.camel@grayson> <1136756756.1043.20.camel@grayson>
 <1136792769.2936.13.camel@laptopd505.fenrus.org> <1136813649.1043.30.camel@grayson>
 <1136842100.2936.34.camel@laptopd505.fenrus.org> <1141841013.24202.194.camel@grayson>
 <9a8748490603081105i3468fa84haac329d1e50faed4@mail.gmail.com>
 <1141845047.12175.7.camel@laptopd505.fenrus.org>
 <9a8748490603081127r1b830c5bg94f42e021e2a2d58@mail.gmail.com>
 <1149284317.4533.312.camel@grayson>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>With the large amount of hardware available for Linux, it's becoming
>
I do not know about LK customs, but in school we were always forced to write
truncations out ("it is" rather than "it's").

>Some even see it as giving up control of their code. This is simply not the
>case, and the end result is always beneficial to users and developers alike.
>
Frankly, they have to give up their coding style. A common style
throughout the kernel is reasonable, though. But in some aspects
it really gets nitpicky (spaces vs tabs to name one).

>The code review process is there for two reasons. First, it ensures that
>only good code, that follows current API's and coding practices, gets into

Should read: "that follows current APIs"

>locking issues as well as big-endian/little-endian and 64-bit portability.

Suggestion: "as well as endianness and ..."



Jan Engelhardt
-- 
