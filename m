Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261767AbREPBw0>; Tue, 15 May 2001 21:52:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261768AbREPBwP>; Tue, 15 May 2001 21:52:15 -0400
Received: from geos.coastside.net ([207.213.212.4]:9661 "EHLO
	geos.coastside.net") by vger.kernel.org with ESMTP
	id <S261767AbREPBwF>; Tue, 15 May 2001 21:52:05 -0400
Mime-Version: 1.0
Message-Id: <p05100335b7278c9651ef@[207.213.214.37]>
In-Reply-To: <Pine.LNX.4.33.0105152132580.30128-100000@xanadu.home>
In-Reply-To: <Pine.LNX.4.33.0105152132580.30128-100000@xanadu.home>
Date: Tue, 15 May 2001 18:51:45 -0700
To: Nicolas Pitre <nico@cam.org>, Daniel Phillips <phillips@bonn-fries.net>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: LANANA: To Pending Device Number Registrants
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 9:34 PM -0400 2001-05-15, Nicolas Pitre wrote:
>On Wed, 16 May 2001, Daniel Phillips wrote:
>
>>  On Tuesday 15 May 2001 23:20, Nicolas Pitre wrote:
>>  > Personally, I'd really like to see /dev/ttyS0 be the first detected
>>  > serial port on a system, /dev/ttyS1 the second, etc.
>>
>>  There are well-defined rules for the first four on PC's.  The ttySx
>>  better match the labels the OEM put on the box.
>
>Then just make them be detected first.

Well, they traditionally start with 1, not 0, too. Or have cute 
little icons and no text. Or aren't labelled at all. I'm using one 
fairly well-known dual-port PCI serial board that silently 
interchanged the two ports on a rev change, with no labelling change 
at all ('cause there was no label!). Make your ttySx match *that*!

-- 
/Jonathan Lundell.
