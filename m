Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272622AbRIGMb2>; Fri, 7 Sep 2001 08:31:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272623AbRIGMbS>; Fri, 7 Sep 2001 08:31:18 -0400
Received: from mail11.speakeasy.net ([216.254.0.211]:13325 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP
	id <S272622AbRIGMbC>; Fri, 7 Sep 2001 08:31:02 -0400
Content-Type: text/plain; charset=US-ASCII
From: safemode <safemode@speakeasy.net>
To: Daniel Phillips <phillips@bonn-fries.net>, Robert Love <rml@tech9.net>,
        Christoph Lameter <christoph@lameter.com>
Subject: Re: Linux Preemptive patch success 2.4.10-pre4 + lots of other patches
Date: Fri, 7 Sep 2001 08:31:22 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0109062135280.1643-100000@devel.office> <999837964.865.3.camel@phantasy> <20010907051231Z16200-26183+114@humbolt.nl.linux.org>
In-Reply-To: <20010907051231Z16200-26183+114@humbolt.nl.linux.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010907123107Z272622-761+7779@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm using the 2.4.9-ac9 preempt patch to test things out.  Everything is fine 
and stable except it seems that sudden and rapid network accesses cause tiny 
"pops" in the soundcard that didn't occur before the patch.  This is not 
increased system load or anything so the audio isn't skipping due to that. 
It has only happened so far when grabbing many tiny files in rapid succession 
(note. only at 70K/s).  Weird.
