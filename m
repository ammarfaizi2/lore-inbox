Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316847AbSF0Ntv>; Thu, 27 Jun 2002 09:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316849AbSF0Ntu>; Thu, 27 Jun 2002 09:49:50 -0400
Received: from server72.aitcom.net ([208.234.0.72]:28786 "EHLO test-area.com")
	by vger.kernel.org with ESMTP id <S316847AbSF0Ntt>;
	Thu, 27 Jun 2002 09:49:49 -0400
Message-Id: <200206271349.JAA16318@test-area.com>
Content-Type: text/plain; charset=US-ASCII
From: anton wilson <anton.wilson@camotion.com>
To: linux-kernel@vger.kernel.org
Subject: printks in the scheduler freeze during scripts
Date: Thu, 27 Jun 2002 10:03:30 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I'm running linux 2.4.17 and Redhat 7.2 with the preemptive and low latency 
patches, and whenever I stick printks in the scheduler(void) my system 
freezes somewhere after it tries to load the system font. Where it stops 
seems to be random. I can only run under single user mode without my system 
freezing. Does anyone have any clues why? Or any better ways to go about 
tracking the scheduling of processes in the scheduler?


Anton
-- 
Camotion
Software Development
678-471-0895
