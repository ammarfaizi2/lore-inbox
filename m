Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266230AbRF3RtG>; Sat, 30 Jun 2001 13:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266228AbRF3Rs4>; Sat, 30 Jun 2001 13:48:56 -0400
Received: from nic.lth.se ([130.235.20.3]:15493 "EHLO nic.lth.se")
	by vger.kernel.org with ESMTP id <S266230AbRF3Rsu>;
	Sat, 30 Jun 2001 13:48:50 -0400
Date: Sat, 30 Jun 2001 19:48:36 +0200
From: Jakob Borg <jakob@borg.pp.se>
To: Jordan <ledzep37@home.com>, Jordan Breeding <jordan.breeding@inet.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: USB Keyboard errors with 2.4.5-ac
Message-ID: <20010630194835.A730@borg.pp.se>
In-Reply-To: <3B3CBA86.355500A@inet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B3CBA86.355500A@inet.com>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux narayan 2.4.3 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 29, 2001 at 12:27:34PM -0500, Jordan Breeding wrote:
> lock a couple of times then the keyboard stops responding completely and
> the kernel tells me that there was an error waiting on a IRQ on CPU #1. 

You are using an SMP kernel. In my experience, nothing USB works with an SMP
kernel >2.4.3.

//jb
