Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136713AbREAUuD>; Tue, 1 May 2001 16:50:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136715AbREAUty>; Tue, 1 May 2001 16:49:54 -0400
Received: from cc78409-a.hnglo1.ov.nl.home.com ([213.51.107.234]:24842 "EHLO
	dexter.hensema.xs4all.nl") by vger.kernel.org with ESMTP
	id <S136713AbREAUtq>; Tue, 1 May 2001 16:49:46 -0400
Date: Tue, 1 May 2001 22:49:43 +0200
From: Erik Hensema <erik@hensema.xs4all.nl>
To: linux-kernel@vger.kernel.org
Subject: Meaning of major kernel version number
Message-ID: <20010501224943.A21208@hensema.xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A little question which may be a FAQ: what does the major version number
[1] of the Linux kernel (still) mean? What is the policy on increasing the
major version (eg. on what basis it is decided the next kernel isn't going
to be 2.6 but 3.0)?

I'm asking this question because I think there isn't going to be a
kernel which is as different from the previous one as 2.0 compared to 1.2.
As a little reminder: 2.0 brought us SMP, modules, multi-platform support
(did 1.2 support Alpha? I don't remember), quota support, MD support, loop
device, to name a few.

If this is true, may have to rethink the current versioning scheme, or
we'll stick to 2.x.y forever...

-- 
Erik Hensema (erik@hensema.xs4all.nl)
