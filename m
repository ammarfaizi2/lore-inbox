Return-Path: <linux-kernel-owner+w=401wt.eu-S1751141AbXAIHai@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbXAIHai (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 02:30:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751135AbXAIHai
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 02:30:38 -0500
Received: from maxwell.spina.si ([193.77.104.223]:52009 "EHLO maxwell.spina.si"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751141AbXAIHai (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 02:30:38 -0500
Message-ID: <45A34517.2030102@kanardia.eu>
Date: Tue, 09 Jan 2007 08:32:39 +0100
From: Rok Markovic <kernel@kanardia.eu>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Accelerated driver for linux 2.6
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I would like to ask how can I start writing accelerated driver on linux. 
Right now I
am realy confused, because there is no real documentation about it (or I 
can't find one).
We get the documentation which is describing hardware (sort of?!) from 
manufactorer,
and that's it.

Target platform for this driver is linux 2.6 runing Qtopia application - 
without X server.

This message could be a bit confusing, but that is how I feel at the moment.

I am not planing to implement whole 3D accelerating (for now), but only 
implement 2D blit and
multisampling.

Cheers,
Rok Markovic


