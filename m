Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131224AbRC0LjC>; Tue, 27 Mar 2001 06:39:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131221AbRC0Liw>; Tue, 27 Mar 2001 06:38:52 -0500
Received: from probity.mcc.ac.uk ([130.88.200.94]:57357 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S131224AbRC0Lip>; Tue, 27 Mar 2001 06:38:45 -0500
Date: Tue, 27 Mar 2001 12:38:01 +0100 (BST)
From: John Levon <moz@compsoc.man.ac.uk>
To: Dinesh Nagpure <fatbrrain@hotmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: hooking APIC timer doesnt work?
In-Reply-To: <F67E8NpqhNPPzQT456U0000bad6@hotmail.com>
Message-ID: <Pine.LNX.4.21.0103271237040.32547-100000@mrbusy.compsoc.man.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Mar 2001, Dinesh Nagpure wrote:

> Hello all,
> I am trying to use the LAPIC timer to generate interrupt for some kernel 
> profiling work I am doing...but the timer ISR isnt invoking atall....here is 
> what I have done....
> 

Have you seen Vincent Oberle's APIC timers module ? There is a link at kernelnewbies.org

Also, what are you doing with the perfctr interrupt ? Are you aware of perfctr and oprofile ?

john

-- 
"Stop telling God what to do." 
	- Niels Bohr 

