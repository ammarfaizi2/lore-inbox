Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277307AbRJEEgq>; Fri, 5 Oct 2001 00:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277309AbRJEEgg>; Fri, 5 Oct 2001 00:36:36 -0400
Received: from rdu26-57-156.nc.rr.com ([66.26.57.156]:10386 "EHLO
	gateway.house") by vger.kernel.org with ESMTP id <S277307AbRJEEgY>;
	Fri, 5 Oct 2001 00:36:24 -0400
Subject: Re: Development Setups
From: Michael Rothwell <rothwell@holly-springs.nc.us>
To: adam.keys@HOTARD.engr.smu.edu
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011005041759.OPDP14306.femail26.sdc1.sfba.home.com@there>
In-Reply-To: <20011005041759.OPDP14306.femail26.sdc1.sfba.home.com@there>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99 (Preview Release)
Date: 05 Oct 2001 00:36:53 -0400
Message-Id: <1002256614.20235.6.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2001-10-05 at 00:20, Adam Keys wrote:
> As a budding kernel hacker looking to cut my teeth, I've become curious about 
> what types of setups people hack the kernel with.  I am very interested in 
> descriptions of the computers you hack the kernel with and their use patterns.

Here's what each developer was equipped with at my former place of
employment, back when they had money and all:

Two x86 machines, one workstation and one "blow up box".

Console on serial port, minicom logging to a file.

/usr/src on the "blow up box" nfs-mounted from workstation; 100MBit
ethernet

Used kdb sometimes.


