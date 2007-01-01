Return-Path: <linux-kernel-owner+w=401wt.eu-S1755194AbXAAL3T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755194AbXAAL3T (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 06:29:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755195AbXAAL3T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 06:29:19 -0500
Received: from outgoing1.smtp.agnat.pl ([193.239.44.83]:51501 "EHLO
	outgoing1.smtp.agnat.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755194AbXAAL3S convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 06:29:18 -0500
From: Arkadiusz Miskiewicz <arekm@maven.pl>
Organization: SelfOrganizing
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Happy New Year (and v2.6.20-rc3 released)
Date: Mon, 1 Jan 2007 12:29:08 +0100
User-Agent: KMail/1.9.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0612311710430.4473@woody.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200701011229.08237.arekm@maven.pl>
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 January 2007 02:19, Linus Torvalds wrote:
> In order to not get in trouble with MADR ("Mothers Against Drunk
> Releases") I decided to cut the 2.6.20-rc3 release early rather than wait
> for midnight, because it's bound to be new years _somewhere_ out there. So
> here's to a happy 2007 for everybody.

I hope that upcoming gcc 4.2 will be considered as supported compiler before 
final 2.6.20 release and patch which broke build is reverted or the thing 
fixed :)


  MODPOST 1371 modules
WARNING: "_proxy_pda" [fs/fuse/fuse.ko] undefined!
make[1]: *** [__modpost] B³±d 1

+ some other modules which I didn't enable this time

-- 
Arkadiusz Mi¶kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
