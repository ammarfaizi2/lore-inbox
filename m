Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbUKQDhg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbUKQDhg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 22:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbUKQDhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 22:37:36 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:30643 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S262191AbUKQDhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 22:37:31 -0500
From: Darren Williams <dsw@gelato.unsw.edu.au>
To: Timothy Miller <miller@techsource.com>
Date: Wed, 17 Nov 2004 14:37:22 +1100
Cc: Darren Williams <dsw@gelato.unsw.edu.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Intel Corp. 82801BA/BAM not supported by ALSA?
Message-ID: <20041117033722.GB4069@cse.unsw.EDU.AU>
Mail-Followup-To: Timothy Miller <miller@techsource.com>,
	Darren Williams <dsw@gelato.unsw.edu.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <419914F9.7050509@techsource.com> <20041115234623.GA19452@cse.unsw.EDU.AU> <419A7927.6090608@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <419A7927.6090608@techsource.com>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Timothy

On Tue, 16 Nov 2004, Timothy Miller wrote:

> 
> Alright, thanks for the suggestions [snipped].  I managed to get a 
> number of the sound-related things to work.  Unfortunately, it still 
> doesn't work 100%.
> 
> Now, KDE sounds seem to work, for instance, the bell sound in konsole 
> when you try to backspace too many times.  However, that sound comes out 
> noisy, raspy, and the wrong pitch.
> 
> I tried using 'aplay' with some wav files.  When I just do 'aplay 
> <filename>', I get silence.  When I do 'strace aplay <filename>', I get 
> lots of noise and output like this:
> 
> 
I would suggest you try the alsa mail lists now to
see if they have any more suggestions.
http://www.alsa-project.org/mailing-lists.php

Could be a driver problem.

--------------------------------------------------
Darren Williams <dsw AT gelato.unsw.edu.au>
Gelato@UNSW <www.gelato.unsw.edu.au>
--------------------------------------------------
