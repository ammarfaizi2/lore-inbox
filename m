Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286789AbRL1I2U>; Fri, 28 Dec 2001 03:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286784AbRL1I2K>; Fri, 28 Dec 2001 03:28:10 -0500
Received: from johnsl.lnk.telstra.net ([139.130.12.152]:31242 "HELO
	ns.higherplane.net") by vger.kernel.org with SMTP
	id <S286790AbRL1I17>; Fri, 28 Dec 2001 03:27:59 -0500
Date: Fri, 28 Dec 2001 19:28:42 +1100
From: john slee <indigoid@higherplane.net>
To: Brian Craft <bcboy@thecraftstudio.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: pasting arbitrary input to consoles
Message-ID: <20011228192842.A20717@higherplane.net>
In-Reply-To: <20011227141759.A19460@bcboy-linux.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011227141759.A19460@bcboy-linux.cisco.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 27, 2001 at 02:17:59PM -0800, Brian Craft wrote:
> Another option would be to run a terminal emulator, like screen, that
> was voice aware. Can such a program be wedged between the user and the
> os early during boot?

[gq}]

there is an example and associated discussion of doing this sort of
wedging (similar to screen or script, as mentioned in another post) in
W. Richard Stevens' "Advanced Programming in the UNIX Environment".

also i think 'expect' may be a useful utility to look at for an example.

good luck, it sounds like a very worthwhile project you are working on.

j.

-- 
R N G G   "Well, there it goes again... And we just sit 
 I G G G   here without opposable thumbs." -- gary larson
