Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265188AbTLFPKb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 10:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265191AbTLFPKa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 10:10:30 -0500
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:6629 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S265188AbTLFPKa convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 10:10:30 -0500
To: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] Rootkit queston
References: <874qwehxf1.wl@drakkar.ibe.miee.ru> <yw1x65gu7zy7.fsf@kth.se>
From: Doug McNaught <doug@mcnaught.org>
Date: Sat, 06 Dec 2003 10:10:18 -0500
In-Reply-To: <yw1x65gu7zy7.fsf@kth.se> (
 =?iso-8859-1?q?M=E5ns_Rullg=E5rd's_message_of?= "Sat, 06 Dec 2003 16:01:20
 +0100")
Message-ID: <87ad66ugmd.fsf@asmodeus.mcnaught.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/20.7 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mru@kth.se (Måns Rullgård) writes:

> Suppose you found a bug in a web server that would make the server
> append arbitrary data to existing files.  Adding that line to
> inetd.conf would be one way to use that bug to gain full control over
> the machine.

But the inetd.conf line itself isn't an "attack"; it's a backdoor put
in after an attack is successful.

Just terminology...  :)

-Doug
