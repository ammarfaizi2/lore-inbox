Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264253AbSIQPIh>; Tue, 17 Sep 2002 11:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264256AbSIQPIh>; Tue, 17 Sep 2002 11:08:37 -0400
Received: from speech.braille.uwo.ca ([129.100.109.30]:50339 "EHLO
	speech.braille.uwo.ca") by vger.kernel.org with ESMTP
	id <S264253AbSIQPIg>; Tue, 17 Sep 2002 11:08:36 -0400
To: Roberto Nibali <ratz@drugphish.ch>
Cc: Skip Ford <skip.ford@verizon.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.35 undefined reference to `wait_task_inactive'
References: <200209160644.g8G6iEvo006691@pool-141-150-241-241.delv.east.verizon.net>
	<x7sn08k7r0.fsf@speech.braille.uwo.ca> <3D87422B.3080300@drugphish.ch>
	<3D8744CA.6090300@drugphish.ch>
From: Kirk Reiser <kirk@braille.uwo.ca>
Date: 17 Sep 2002 11:13:33 -0400
In-Reply-To: <3D8744CA.6090300@drugphish.ch>
Message-ID: <x7ofawk5sy.fsf@speech.braille.uwo.ca>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roberto Nibali <ratz@drugphish.ch> writes:

> Roberto Nibali wrote:
> Actually the correct fix seems to be already in Linus' tree:
> 
> ChangeSet@1.564, 2002-09-15 22:53:19-07:00, david@gibson.dropbear.id.au
>    [PATCH] Remove CONFIG_SMP around wait_task_inactive()
> 
> So after all, my patch wasn't all that wrong, just a little ... ;).

Thanks Roberto for the quick responce.

  Kirk

-- 

Kirk Reiser				The Computer Braille Facility
e-mail: kirk@braille.uwo.ca		University of Western Ontario
phone: (519) 661-3061
