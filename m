Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751164AbVIBNrP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbVIBNrP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 09:47:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbVIBNrP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 09:47:15 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:39176 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1751164AbVIBNrO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 09:47:14 -0400
To: Olaf Dietsche <olaf+list.linux-kernel@olafdietsche.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.6.13: Filesystem capabilities 0.16
References: <87ll2ghb95.fsf@goat.bogus.local>
From: Nix <nix@esperi.org.uk>
X-Emacs: ed  ::  20-megaton hydrogen bomb : firecracker
Date: Fri, 02 Sep 2005 14:47:09 +0100
In-Reply-To: <87ll2ghb95.fsf@goat.bogus.local> (Olaf Dietsche's message of
 "1 Sep 2005 19:52:27 +0100")
Message-ID: <87fysnmvj6.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Sep 2005, Olaf Dietsche murmured woefully:
> This patch implements filesystem capabilities. It allows to run
> privileged executables without the need for suid root.

Is there some reason why this doesn't keep its capability data in
xattrs?

-- 
`... published last year in a limited edition... In one of the
 great tragedies of publishing, it was not a limited enough edition
 and so I have read it.' --- James Nicoll
