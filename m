Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313202AbSD3Psd>; Tue, 30 Apr 2002 11:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313205AbSD3Psc>; Tue, 30 Apr 2002 11:48:32 -0400
Received: from mustard.heime.net ([194.234.65.222]:62664 "EHLO
	mustard.heime.net") by vger.kernel.org with ESMTP
	id <S313202AbSD3Psc>; Tue, 30 Apr 2002 11:48:32 -0400
Date: Tue, 30 Apr 2002 17:48:25 +0200 (CEST)
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
X-X-Sender: roy@mustard.heime.net
To: linux-kernel@vger.kernel.org
Subject: IDE hotplug support?
Message-ID: <Pine.LNX.4.44.0204301746020.2301-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi

I came across a nice case from procase, supporting 16 IDE drives in 
(so-called?) hotplug frames. Problem is... How will linux trat this?

I plan to use 15 drives in a RAID-5, assigning the last 16th drive as a 
spare.

Any good ideas?

Sorry if this is OT

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

