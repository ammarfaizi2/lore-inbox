Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265815AbSLNS7M>; Sat, 14 Dec 2002 13:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265816AbSLNS7M>; Sat, 14 Dec 2002 13:59:12 -0500
Received: from smtp018.mail.yahoo.com ([216.136.174.115]:43018 "HELO
	smtp018.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S265815AbSLNS7M>; Sat, 14 Dec 2002 13:59:12 -0500
Date: Sat, 14 Dec 2002 13:15:39 -0600
From: Courtney Grimland <cgrimland@yahoo.com>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-ac1 KT400 AGP support
Message-Id: <20021214131539.4b73faa9.cgrimland@yahoo.com>
In-Reply-To: <20021214101327.GB30545@suse.de>
References: <2F4E8F809920D611B0B300508BDE95FE294452@AFB91>
	<20021213195759.3233dc42.cgrimland@yahoo.com>
	<20021214101327.GB30545@suse.de>
X-Mailer: Sylpheed version 0.8.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Operating-System: Real Men Don't Use Distros - www.linuxfromscratch.org
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That's retarded.  I guess I just got lucky with mine.  In fact, now
that I can build a monolithic 2.4.x that supports my AGP and
8235 sound, I couldn't be happier with my Gigabyte 7VAXP.

On Sat, 14 Dec 2002 10:13:27 +0000
Dave Jones <davej@codemonkey.org.uk> wrote:


> Aparently some KT400 BIOS's got clever, and took away the option.
> They switch to AGP 3.0 if an AGP 3.0 card is present, and drop
> back to 2.0 if a 2.0 card is present.
