Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261996AbTAEACs>; Sat, 4 Jan 2003 19:02:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262040AbTAEACs>; Sat, 4 Jan 2003 19:02:48 -0500
Received: from mail41-s.fg.online.no ([148.122.161.41]:40613 "EHLO
	mail41.fg.online.no") by vger.kernel.org with ESMTP
	id <S261996AbTAEACs>; Sat, 4 Jan 2003 19:02:48 -0500
Message-ID: <3E17781D.30702@pvv.org>
Date: Sun, 05 Jan 2003 01:11:09 +0100
From: =?ISO-8859-1?Q?=D8ystein_Svendsen?= <svendsen@pvv.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
MIME-Version: 1.0
To: Johannes Erdfelt <johannes@erdfelt.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem with uhci and usb-uhci
References: <E18UxuX-0001yJ-00@localhost> <20030104184649.B14645@sventech.com>
In-Reply-To: <20030104184649.B14645@sventech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Erdfelt wrote:

>Have you tried this with OHCI?
>
I am not able to load the OHCI driver on my system, so the answer is no. 
 I guess my hardware is not compatible.

>The error message for uhci.o atleast is returning back a babble error
>which will then stall the pipe.
>
>A babble error is usually a driver or device issue.
>  
>
I am not very familiar on how the USB stuff works, but I'll try to take 
a look on the usb-midi.c after I get some sleep.  I was assuming there 
was trouble with the UHCI stuff because the USB bus seems to remain 
stalled even after i unplug the MIDI adapter from the USB bus.

-- 
    Øystein Svendsen 



