Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265092AbTAETkm>; Sun, 5 Jan 2003 14:40:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265085AbTAETkm>; Sun, 5 Jan 2003 14:40:42 -0500
Received: from air-2.osdl.org ([65.172.181.6]:25472 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265074AbTAETkl>;
	Sun, 5 Jan 2003 14:40:41 -0500
Date: Sun, 5 Jan 2003 11:46:03 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Paul Rolland <rol@as2917.net>
cc: "'Andrew S. Johnson'" <andy@asjohnson.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.54 + ACPI] Slow [Was: Re: [2.5.53] So sloowwwww......]
In-Reply-To: <013701c2b4f2$3f3e0670$2101a8c0@witbe>
Message-ID: <Pine.LNX.4.33L2.0301051145050.13312-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Jan 2003, Paul Rolland wrote:

| Hello,
|
| > | | acpi= kernel parameters, I tried :
| > | |  - acpi=no-idle
| > |
| > | This one (above) is the correct syntax.
| > | Looking at the code, it only takes effect if you are using
| > only 1 CPU.
| >
| > Sorry, I was looking at old source code.
| > apm=no-idle isn't in 2.5.54.
s/apm/acpi/ !!!

| Too bad...
| Does this mean there is no easy way to have ACPI running correctly
| on my machine ?
| If anyone knows ACPI code, please tell me if you want me to run
| some specific code to understand what's going on...

I'll have to leave that to someone else.

-- 
~Randy

