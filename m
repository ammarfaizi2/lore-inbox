Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWATOTn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWATOTn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 09:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751014AbWATOTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 09:19:43 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:50094 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751013AbWATOTm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 09:19:42 -0500
Date: Fri, 20 Jan 2006 15:19:26 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
cc: Lee Revell <rlrevell@joe-job.com>,
       "=?iso-8859-1?q?Fr=E9d=E9ric?= L. W. Meunier" <2@pervalidus.net>,
       Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org,
       perrye@linuxmail.org
Subject: Re: RFC: OSS driver removal, a slightly different approach
In-Reply-To: <200601192203.11032.s0348365@sms.ed.ac.uk>
Message-ID: <Pine.LNX.4.61.0601201519050.22940@yvahk01.tjqt.qr>
References: <20060119174600.GT19398@stusta.de> <Pine.LNX.4.64.0601191815550.1300@dyndns.pervalidus.net>
 <1137703548.32195.25.camel@mindpipe> <200601192203.11032.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > Why aren't drivers like SOUND_TVMIXER listed ? That one isn't
>> > in ALSA, but there's a port at
>> > http://www.gilfillan.org/v3tv/ALSA/ . It's now the only I
>> > enable in OSS.
>>
>> Grr... why would someone bother to write a driver then not submit it or
>> even tell the ALSA maintainers?

Fear of not getting it included?


Jan Engelhardt
-- 
