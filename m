Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278772AbRJ3Xnm>; Tue, 30 Oct 2001 18:43:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278798AbRJ3Xnc>; Tue, 30 Oct 2001 18:43:32 -0500
Received: from mail116.mail.bellsouth.net ([205.152.58.56]:50482 "EHLO
	imf16bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S278789AbRJ3XnV>; Tue, 30 Oct 2001 18:43:21 -0500
Message-ID: <3BDF3B3D.3CAB3918@mandrakesoft.com>
Date: Tue, 30 Oct 2001 18:43:57 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, andrea@suse.de
Subject: Re: pre5 VM livelock
In-Reply-To: <Pine.LNX.4.33.0110301436550.1188-100000@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Question: did you have some big process that you tried to test the VM
> with? Did you expect the oom killer to kill it?

AFAICT, yes.  I am going to re-run again to make sure (both with pre5
and also pre5aa1).

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

