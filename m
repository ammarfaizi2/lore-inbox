Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136743AbREHE2T>; Tue, 8 May 2001 00:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136744AbREHE2K>; Tue, 8 May 2001 00:28:10 -0400
Received: from as2-4-3.an.g.bonet.se ([194.236.34.191]:18437 "EHLO
	zigo.dhs.org") by vger.kernel.org with ESMTP id <S136742AbREHE14>;
	Tue, 8 May 2001 00:27:56 -0400
Date: Tue, 8 May 2001 06:27:52 +0200 (CEST)
From: Dennis Bjorklund <db@zigo.dhs.org>
To: <linux-kernel@vger.kernel.org>
Subject: monitor file writes
Message-ID: <Pine.LNX.4.30.0105080624120.14983-100000@merlin.zigo.dhs.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a way in linux to montior file writes?

I have something that is writing to the disk every 5:th second (approx.)
And I don't know what it is.. In windows I had a small program called
FileMonitor that where quite good in this situation.

Is there such a program i linux? If not, is it because the kernel does not
provide this information. Maybe there is needed some new hooks to make it
possible?

-- 
/Dennis

