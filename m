Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267299AbTBPSAd>; Sun, 16 Feb 2003 13:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267310AbTBPSAd>; Sun, 16 Feb 2003 13:00:33 -0500
Received: from csa.iisc.ernet.in ([144.16.67.8]:3969 "EHLO csa.iisc.ernet.in")
	by vger.kernel.org with ESMTP id <S267299AbTBPSAd>;
	Sun, 16 Feb 2003 13:00:33 -0500
Date: Sun, 16 Feb 2003 23:40:12 +0530 (IST)
From: Rahul Vaidya <rahulv@csa.iisc.ernet.in>
To: John Levon <levon@movementarian.org>
Cc: Zwane Mwaikambo <zwane@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: linux 2.5.53 not compiling
In-Reply-To: <20030216174118.GA63890@compsoc.man.ac.uk>
Message-ID: <Pine.SOL.3.96.1030216233839.25827F-100000@osiris.csa.iisc.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>> Have you made a softlink for gcc ? Apparently that doesn't work well
>> with recent gcc versions finding the headers...
>> 
>> john

The gcc I was using is a softlink. So I aliased it to the actual file and
again tried "make bzImage". It dint work :(

