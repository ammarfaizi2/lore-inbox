Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262915AbSIQO0f>; Tue, 17 Sep 2002 10:26:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264183AbSIQO0e>; Tue, 17 Sep 2002 10:26:34 -0400
Received: from speech.braille.uwo.ca ([129.100.109.30]:48034 "EHLO
	speech.braille.uwo.ca") by vger.kernel.org with ESMTP
	id <S262915AbSIQO0e>; Tue, 17 Sep 2002 10:26:34 -0400
To: Skip Ford <skip.ford@verizon.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.35 undefined reference to `wait_task_inactive'
References: <200209160644.g8G6iEvo006691@pool-141-150-241-241.delv.east.verizon.net>
From: Kirk Reiser <kirk@braille.uwo.ca>
Date: 17 Sep 2002 10:31:31 -0400
In-Reply-To: <200209160644.g8G6iEvo006691@pool-141-150-241-241.delv.east.verizon.net>
Message-ID: <x7sn08k7r0.fsf@speech.braille.uwo.ca>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Skip Ford <skip.ford@verizon.net> writes:

> A call to wait_task_inactive was added to fs/exec.c but that function is
> not defined for UP.

I haven't seen a fix for this yet?  

  Kirk

-- 

Kirk Reiser				The Computer Braille Facility
e-mail: kirk@braille.uwo.ca		University of Western Ontario
phone: (519) 661-3061
