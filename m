Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287502AbSASWV7>; Sat, 19 Jan 2002 17:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287539AbSASWVt>; Sat, 19 Jan 2002 17:21:49 -0500
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:40338
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S287502AbSASWVl>; Sat, 19 Jan 2002 17:21:41 -0500
Date: Sat, 19 Jan 2002 15:20:14 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Rob Radez <rob@osinvestor.com>
Cc: linux-kernel@vger.kernel.org, Andre Hedrick <andre@linux-ide.org>
Subject: Re: [PATCH] Andre's IDE Patch (1/7)
Message-ID: <20020119222014.GD1623@cpe-24-221-152-185.az.sprintbbd.net>
In-Reply-To: <Pine.LNX.4.33.0201191457490.14950-100000@pita.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201191457490.14950-100000@pita.lan>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2002 at 04:58:42PM -0500, Rob Radez wrote:

> This is the first of seven patches against 2.4.18-pre4

Do you wanna wait and do this again vs 2.4.18-final (for 2.4.19-pre1?)
Maybe I missed something but this is still a large set of changes to a
working subsystem, and requires drivers not in Andres patchset (like say
the ones for PowerMacs) to be updated occordingly.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
