Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262874AbVHEGYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbVHEGYr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 02:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262875AbVHEGYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 02:24:47 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:13267 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262874AbVHEGY1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 02:24:27 -0400
Date: Fri, 5 Aug 2005 08:24:16 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Davy Durham <pubaddr2@davyandbeth.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: /proc question
In-Reply-To: <42F30252.3080105@davyandbeth.com>
Message-ID: <Pine.LNX.4.61.0508050823530.20623@yvahk01.tjqt.qr>
References: <42F30252.3080105@davyandbeth.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have a zombie process which has apparently died for some unknown reason.. I
> know it was terminated by a signal (found that from the 9th field (sheduler
> flags) in /proc/pid/stat)

Start the process under the observation of strace.

> However, I'm trying to figure out what signal killed it.


Jan Engelhardt
-- 
