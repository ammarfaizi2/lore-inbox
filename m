Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751309AbWAIUWX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751309AbWAIUWX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 15:22:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751312AbWAIUWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 15:22:23 -0500
Received: from smtp-2.smtp.ucla.edu ([169.232.47.136]:5321 "EHLO
	smtp-2.smtp.ucla.edu") by vger.kernel.org with ESMTP
	id S1751309AbWAIUWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 15:22:22 -0500
Date: Mon, 9 Jan 2006 12:22:19 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Roberto Nibali <ratz@drugphish.ch>
cc: Willy Tarreau <willy@w.ods.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: bad pmd filemap.c, oops; 2.4.30 and 2.4.32
In-Reply-To: <43C2C482.6090904@drugphish.ch>
Message-ID: <Pine.LNX.4.64.0601091221260.1900@potato.cts.ucla.edu>
References: <Pine.LNX.4.64.0512270844080.14284@potato.cts.ucla.edu>
 <20051228001047.GA3607@dmt.cnet> <Pine.LNX.4.64.0512281806450.10419@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0512301610320.13624@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0512301732170.21145@potato.cts.ucla.edu>
 <1136030901.28365.51.camel@localhost.localdomain> <20051231130151.GA15993@alpha.home.local>
 <Pine.LNX.4.64.0601041402340.28134@potato.cts.ucla.edu> <20060105054348.GA28125@w.ods.org>
 <Pine.LNX.4.64.0601061352510.24856@potato.cts.ucla.edu>
 <Pine.LNX.4.64.0601061411350.24856@potato.cts.ucla.edu> <43BF8785.2010703@drugphish.ch>
 <Pine.LNX.4.64.0601070246150.29898@potato.cts.ucla.edu> <43C2C482.6090904@drugphish.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Probable-Spam: no
X-Spam-Report: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2006, Roberto Nibali wrote:

>>> What's the SCSI BIOS version?
>> 
>> The SCSI controller is an onboard AIC 7899 (in a Dell PowerEdge 2650), 
>> and reports itself as "25309".
>
> What I meant was the SCSI Bios revision you get to see when you cold 
> reset the system.

That is the SCSI BIOS rev.  The machine is a Dell PowerEdge 2650 and 
that's the onboard AIC 7899.  It comes up as "BIOS Build 25309".


-Chris
