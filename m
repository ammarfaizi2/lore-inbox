Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261745AbREPBBa>; Tue, 15 May 2001 21:01:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261743AbREPBBU>; Tue, 15 May 2001 21:01:20 -0400
Received: from fjordland.nl.linux.org ([131.211.28.101]:36357 "EHLO
	fjordland.nl.linux.org") by vger.kernel.org with ESMTP
	id <S261745AbREPBBN>; Tue, 15 May 2001 21:01:13 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Nicolas Pitre <nico@cam.org>
Subject: Re: LANANA: To Pending Device Number Registrants
Date: Wed, 16 May 2001 02:59:30 +0200
X-Mailer: KMail [version 1.2]
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0105151713020.30128-100000@xanadu.home>
In-Reply-To: <Pine.LNX.4.33.0105151713020.30128-100000@xanadu.home>
MIME-Version: 1.0
Message-Id: <01051602593001.00406@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 15 May 2001 23:20, Nicolas Pitre wrote:
> Personally, I'd really like to see /dev/ttyS0 be the first detected
> serial port on a system, /dev/ttyS1 the second, etc.

There are well-defined rules for the first four on PC's.  The ttySx 
better match the labels the OEM put on the box.

--
Daniel
