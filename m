Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263372AbTH2M2S (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 08:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263432AbTH2M2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 08:28:18 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:31179 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S263372AbTH2M2R
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 08:28:17 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16207.18144.463818.473825@laputa.namesys.com>
Date: Fri, 29 Aug 2003 16:28:16 +0400
To: Felix Seeger <felix.seeger@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reiser4 snapshot problems
In-Reply-To: <4834.1062157986@www16.gmx.net>
References: <4834.1062157986@www16.gmx.net>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix Seeger writes:
 > Hi
 > 
 > I am trying out Reiser4 snapshot from August 26th.
 > I've putted my kde cvs sources on the new partition and compile from reiser4
 > now.
 > 
 > After some time processes hang when accessing this disk. I cannot do
 > anything on it but I also don't get any errormessage.

If there anything in /var/log/messages, or wherever your kernel log is
stored?

 > 
 > Umount, bash autocomletion and things like that don't work. Normal df and
 > mount are working btw.

Nikita.
