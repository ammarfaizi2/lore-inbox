Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262195AbVDXE0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbVDXE0H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Apr 2005 00:26:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262202AbVDXE0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Apr 2005 00:26:07 -0400
Received: from smtp.blackdown.de ([213.239.206.42]:38096 "EHLO
	smtp.blackdown.de") by vger.kernel.org with ESMTP id S262195AbVDXE0C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Apr 2005 00:26:02 -0400
From: Juergen Kreileder <jk@blackdown.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: 2.6.12-rc2-mm3
References: <20050411012532.58593bc1.akpm@osdl.org>
	<87wtr8rdvu.fsf@blackdown.de> <87u0m7aogx.fsf@blackdown.de>
	<1113607416.5462.212.camel@gaston> <877jj1aj99.fsf@blackdown.de>
	<20050423170152.6b308c74.akpm@osdl.org> <87fyxhj5p1.fsf@blackdown.de>
	<1114308928.5443.13.camel@gaston>
X-PGP-Key: http://blackhole.pca.dfn.de:11371/pks/lookup?op=get&search=0x730A28A5
X-PGP-Fingerprint: 7C19 D069 9ED5 DC2E 1B10  9859 C027 8D5B 730A 28A5
Mail-Followup-To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Andrew
	Morton <akpm@osdl.org>, Linux Kernel list
	<linux-kernel@vger.kernel.org>, Oleg Nesterov <oleg@tv-sign.ru>
Date: Sun, 24 Apr 2005 06:25:38 +0200
In-Reply-To: <1114308928.5443.13.camel@gaston> (Benjamin Herrenschmidt's
	message of "Sun, 24 Apr 2005 12:15:28 +1000")
Message-ID: <87y8b8ssvx.fsf@blackdown.de>
Organization: Blackdown Java-Linux Team
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> If you make sure you have CONFIG_XMON enabled and CONFIG_BOOTX_TEXT,
> and make sure X has "UseFBDev" option, do you drop into xmon before
> the lockup ?

No, instant lockup.


        Juergen

-- 
Juergen Kreileder, Blackdown Java-Linux Team
http://blog.blackdown.de/
