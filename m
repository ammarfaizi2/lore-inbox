Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266091AbTLISvB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 13:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266092AbTLISvA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 13:51:00 -0500
Received: from imap.gmx.net ([213.165.64.20]:43221 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266091AbTLISuw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 13:50:52 -0500
Date: Tue, 9 Dec 2003 19:50:51 +0100 (MET)
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: State of devfs in 2.6?
X-Priority: 3 (Normal)
X-Authenticated: #20183004
Message-ID: <22780.1070995851@www60.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi sorry for using this kind of reply,
but i'm not subscribed to lkml
/* it would be nice if you CC me :-) */

------ original e-mail -----------
On Mon, Dec 08, 2003 at 11:26:17PM -0600, Rob Landley wrote:
> 
> Is there a big rollup patch against that adds all the sys/*/dev entries
for 
> people who want to try udev?

After I get finished catching up on USB patches that people sent me for
the last month, I'll generate this and post it to lkml.

thanks,

greg k-h
-------end original e-mail -----

Greg could you please post them splited,
i'm having some issues with the one that adds
misc devices -- oopses in early boot as described in
http://marc.theaimsgroup.com/?l=linux-kernel&m=107097871212256&w=2

i managed to find 4 of the patches, but i'm still missing
the ones for sound, input, parport

the ones i found are available from the mandrake ml :-)
eg http://marc.theaimsgroup.com/?l=mandrake-cooker&m=107099351100451&w=2
( mem, vcs, fb , misc devices support)

best,

svetljo

-- 
+++ GMX - die erste Adresse für Mail, Message, More +++
Neu: Preissenkung für MMS und FreeMMS! http://www.gmx.net


