Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262449AbTAEDNP>; Sat, 4 Jan 2003 22:13:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbTAEDNP>; Sat, 4 Jan 2003 22:13:15 -0500
Received: from hibernia.jakma.org ([212.17.32.129]:47515 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP
	id <S262449AbTAEDNO>; Sat, 4 Jan 2003 22:13:14 -0500
Date: Sun, 5 Jan 2003 03:21:22 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: linux-kernel@vger.kernel.org, <andre@linux-ide.org>
Subject: Re: Honest does not pay here ...
In-Reply-To: <200301050025.QAA07630@adam.yggdrasil.com>
Message-ID: <Pine.LNX.4.44.0301050314470.16362-100000@fogarty.jakma.org>
X-NSA: iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 4 Jan 2003, Adam J. Richter wrote:

> 	Andre has informed me of a posting made by Linus to the
> gnu.misc.discuss newsgroup (Message-ID
> "4b0rbb$5iu@klaava.helsinki.fi") on December 17, 1995 where he
> basically gave his permission for the EXPORT_SYMBOL
> vs. EXPORT_SYMBOL_GPL system hereby proprietary modules that call only
> EXPORT_SYMBOL symbols are allowed:
> 
> http://groups.google.com/groups?as_umsgid=4b0rbb%245iu%40klaava.helsinki.fi

Why not formalise this in the Linux COPYING file?

It would make things clear, would help people like Andre and
corporations like NVidia to continue to bring drivers to linux. Not a
single person who matters (ie actual kernel contributors) has so far
expressed any opinion (eg in the rash of GPL threads currently
ongoing) that would indicate they are not happy with the current
status quo as detailed in the above post by Linus.

If EXPORT_SYMBOL kernel functions are LGPL (bar the 
EXPORT_SYMBOL_GPL) formalise it in .../COPYING. (and peace can reign 
on l-k once again :) ).

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
Census Taker to Housewife:
Did you ever have the measles, and, if so, how many?

