Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbTIYN6G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Sep 2003 09:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261218AbTIYN6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Sep 2003 09:58:06 -0400
Received: from [170.180.5.203] ([170.180.5.203]:24842 "EHLO
	e151000n0.edmonson.k12.ky.us") by vger.kernel.org with ESMTP
	id S261190AbTIYN6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Sep 2003 09:58:04 -0400
Message-ID: <9A8F8D67DC8ED311BF3E0008C7B9A0ADBAA870@E151000N0>
From: "Norris, Brent" <bnorris@Edmonson.k12.ky.us>
To: "'Robert L. Harris'" <Robert.L.Harris@rdlg.net>,
       "'Dave Gilbert (Home)'" <gilbertd@treblig.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: 128G Limit in Reiserfs? Or the Kernel? Or something else?
Date: Thu, 25 Sep 2003 08:54:25 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Reiser has no inodes so I guarantee your out but it's 
> irrelevant. What does df -k actually show?  You sure you 
> don't have a process with an open log file that's been removed?

No I am pretty sure that I don't have an open log files.  This drive holds
mainly movies and songs.  I still got the error after a reboot, so I don't
think it is possible that there is anything open on it, especially anything
taking up 112G.  It is just a desktop machine so, that would be a real
rarity on it.  Is it possible that there is some error in the file
structure?  The filesystem is less than 12 hours old, but in that 12 hours
there have been a lot of writes to it (namely the whole 128G) so is it
possible something has been corrupted?

Like I said it was a real odd error to get, but this is the first time I
have worked with drives this big, so I didn't know if this was something
everyone knew about.

Brent
