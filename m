Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311320AbSDIUUi>; Tue, 9 Apr 2002 16:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311403AbSDIUUh>; Tue, 9 Apr 2002 16:20:37 -0400
Received: from mx2out.umbc.edu ([130.85.253.52]:21399 "EHLO mx2out.umbc.edu")
	by vger.kernel.org with ESMTP id <S311320AbSDIUUg>;
	Tue, 9 Apr 2002 16:20:36 -0400
Date: Tue, 9 Apr 2002 16:20:17 -0400
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Daniel Gryniewicz <dang@fprintf.net>
cc: Andrew Burgess <aab@cichlid.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Tyan S2462 reboot problems
In-Reply-To: <20020409161412.777aec9a.dang@fprintf.net>
Message-ID: <Pine.SGI.4.31L.02.0204091619260.8816091-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Apr 2002, Daniel Gryniewicz wrote:

> No, I doubt this has anything to do with Linux.   I have a S2460 (which his
> corrected post says he has), which does not power down under linux, and
> *never* warm boots cleanly.  It does power down under windows, so I assume
> ACPI powerdown works and APM does not.  I have gone under the assumption that
> a BIOS upgrade will fix this, but that involves putting a floppy into the box,
> so I haven't done it yet.  The warm boot problems consist of either a hang
> after POST (but before bootloader, OS irrelevent), or really bad video
> corruption.  I don't know if it boot with the video corruption, I've never let
> it try.

I did update to the new BIOS for the 246x (I can never keep them straight
either), and that did help some with the halt and reboot problems I was
having.


--
-- John E. Jasen (jjasen1@umbc.edu)
-- User Error #2361: Please insert coffee and try again.

