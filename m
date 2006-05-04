Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030321AbWEDUke@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030321AbWEDUke (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 16:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030322AbWEDUke
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 16:40:34 -0400
Received: from animx.eu.org ([216.98.75.249]:58752 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S1030321AbWEDUkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 16:40:33 -0400
Date: Thu, 4 May 2006 16:47:08 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Joshua Hudson <joshudson@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: cdrom: a dirty CD can freeze your system
Message-ID: <20060504204708.GC22880@animx.eu.org>
Mail-Followup-To: Joshua Hudson <joshudson@gmail.com>,
	linux-kernel@vger.kernel.org
References: <200605041232.k44CWnFn004411@wildsau.enemy.org> <1146750532.20677.38.camel@localhost.localdomain> <20060504165055.GA22880@animx.eu.org> <1146762658.22308.11.camel@localhost.localdomain> <bda6d13a0605041027kc0edb02icdd11bd103478b05@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bda6d13a0605041027kc0edb02icdd11bd103478b05@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Hudson wrote:
> I've seen this a few times. It never actually hung my system, only one
> virtual console. I wonder if preemptable kernel had something to do
> with that <g>

I don't believe pre-empt has anything to do eith it.  I have a specialized
boot system (vairous types of boot media) w/o preempt turned on because I
want this as small as possible.  It also has this problem.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
 Got Gas???
