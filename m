Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265541AbSLMXBm>; Fri, 13 Dec 2002 18:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbSLMXBm>; Fri, 13 Dec 2002 18:01:42 -0500
Received: from air-2.osdl.org ([65.172.181.6]:33968 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265541AbSLMXBl>;
	Fri, 13 Dec 2002 18:01:41 -0500
Date: Fri, 13 Dec 2002 15:05:10 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Dave Jones <davej@codemonkey.org.uk>
cc: Rod Van Meter <Rod.VanMeter@nokia.com>, <linux-kernel@vger.kernel.org>
Subject: Re: massive compile failures w/ 2.5.51 on RH8.0
In-Reply-To: <20021213122017.GC31187@suse.de>
Message-ID: <Pine.LNX.4.33L2.0212131502030.22946-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Dec 2002, Dave Jones wrote:

| On Thu, Dec 12, 2002 at 09:42:39PM -0800, Randy.Dunlap wrote:
|
|  > and some of these may have patches available for them on lkml.
|  > I know that intermezzo does, from Peter Braam, with a small
|  > follow-up by me, so it's fixable if you want it.  Surely (Rod ;).
|
| >From reading bugzilla #11, it seems even with your additional
| patch intermezzo still has problems..
(I sense a subtle hint here. :)

Hi Dave,

There are just too many Linux 2.5 bugs and patches to keep track
of all of them...i.e., you might have looked at the latest in bugzilla,
but not the latest patches on lkml.  I have updated bugzilla #11
with the info needed to build intermezzo in 2.5.51, either as a
loadable module or built-into-kernel.

-- 
~Randy

