Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290677AbSAYNrG>; Fri, 25 Jan 2002 08:47:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290680AbSAYNqx>; Fri, 25 Jan 2002 08:46:53 -0500
Received: from penguin.ucs.ed.ac.uk ([129.215.70.49]:34578 "EHLO
	penguin.ucs.ed.ac.uk") by vger.kernel.org with ESMTP
	id <S290677AbSAYNqa>; Fri, 25 Jan 2002 08:46:30 -0500
To: "George Bonser" <george@gator.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux console at boot
In-Reply-To: <CHEKKPICCNOGICGMDODJKEPAGBAA.george@gator.com>
From: Kenneth MacDonald <kenny@holyrood.ed.ac.uk>
Date: 25 Jan 2002 13:46:29 +0000
In-Reply-To: "George Bonser"'s message of "Thu, 24 Jan 2002 21:05:45 -0800"
Message-ID: <yqopu3yilvu.fsf@penguin.ucs.ed.ac.uk>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "George" == George Bonser <george@gator.com> writes:

    George> Is there any way to stop the console scrolling during
    George> boot? My reason for this is I am trying to troubleshoot a
    George> boot problem with 2.4.18-pre7 and I would like to give a
    George> more useful report than "it won't boot" but the screen
    George> outputs information every few seconds and I can't "freeze"
    George> the display so I can copy down the initial error(s).

Does keeping SHIFT-PAGEUP help?  It'll warp back to the bottom on
output, but should give you enough time to get what you need.  Try
taking a photo of the screen while pressing that key combination too.

-- 
Kenny

ADML Support, EUCS, The University of Edinburgh, Scotland.
