Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263516AbTD1HEK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 03:04:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263525AbTD1HEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 03:04:10 -0400
Received: from khms.westfalen.de ([62.153.201.243]:8333 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP id S263516AbTD1HEJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 03:04:09 -0400
Date: 28 Apr 2003 08:59:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8khzML8mw-B@khms.westfalen.de>
In-Reply-To: <Pine.BSO.4.44.0304272145580.23296-100000@kwalitee.nolab.conman.org>
Subject: Re: [RFD] Combined fork-exec syscall.
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <3EAC86C4.5070200@redhat.com> <Pine.BSO.4.44.0304272145580.23296-100000@kwalitee.nolab.conman.org>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mark@nolab.conman.org (Mark Grosberg)  wrote on 27.04.03 in <Pine.BSO.4.44.0304272145580.23296-100000@kwalitee.nolab.conman.org>:

> On Sun, 27 Apr 2003, Ulrich Drepper wrote:
>
> > POSIX has a spawn interface, see <spawn.h> on modern systems.  A syscall
> > should be compatible with this interface.
>
> Hmmm. Okay, it isn't listed in my POSIX reference (which is really dated).
>
> I don't have any docs on this...

http://www.opengroup.org/onlinepubs/007904975/functions/posix_spawn.html

or start from here:

http://unix-systems.org/version3/online.html

MfG Kai
