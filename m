Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263087AbSJBMuu>; Wed, 2 Oct 2002 08:50:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263085AbSJBMuu>; Wed, 2 Oct 2002 08:50:50 -0400
Received: from out001pub.verizon.net ([206.46.170.140]:50872 "EHLO
	out001.verizon.net") by vger.kernel.org with ESMTP
	id <S263099AbSJBMuD>; Wed, 2 Oct 2002 08:50:03 -0400
Message-Id: <200210021250.g92CowmI002639@pool-141-150-241-241.delv.east.verizon.net>
Date: Wed, 2 Oct 2002 08:50:54 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Stig Brautaset <s.brautaset@wmin.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.40: menuconfig: no choice of keyboards
References: <20021002113053.GA482@arwen.brautaset.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021002113053.GA482@arwen.brautaset.org>; from s.brautaset@wmin.ac.uk on Wed, Oct 02, 2002 at 12:30:53PM +0100
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at out001.verizon.net from [141.150.241.241] at Wed, 2 Oct 2002 07:55:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stig Brautaset wrote:
> Nothing happens if I go to the "Input Device Support" section in
> menuconf, and pick "Keyboards"; I get no new options. Got around it by
> manually selecting a keyboard in .config to be able to test it further.
> Either I chose the wrong one, or it just doesn't build it anyway, 'cause 
> the machine would not respond on boot. 
> 
> Does it have something to do with the menuconfig bug reported elsewhere?

I get the same menuconfig error, but it doesn't affect the keyboard
options listed.  The keyboard options show up if you select
"Serial i/o support"

-- 
Skip
