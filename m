Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264925AbTLKMyd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 07:54:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264930AbTLKMyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 07:54:33 -0500
Received: from mail.ondacorp.com.br ([200.195.196.14]:65170 "EHLO
	mail.ondacorp.com.br") by vger.kernel.org with ESMTP
	id S264925AbTLKMyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 07:54:32 -0500
Message-ID: <3FD86904.30500@arenanetwork.com.br>
Date: Thu, 11 Dec 2003 10:54:28 -0200
From: dual_bereta_r0x <dual_bereta_r0x@arenanetwork.com.br>
Organization: ArenaNetwork Lan House & Cyber
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6a) Gecko/20031026 Thunderbird/0.4a
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.23 + tmpfs: where's my mem?!
X-Enigmail-Version: 0.82.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

root@hquest:/tmp# cat /etc/slackware-version
Slackware 9.1.0
root@hquest:/tmp# uname -a
Linux hquest 2.4.23 #6 Sat Nov 29 22:47:03 PST 2003 i686 unknown unknown 
GNU/Linux
root@hquest:/tmp# df /tmp
Filesystem           1K-blocks      Used Available Use% Mounted on
tmpfs                   124024    112388     11636  91% /tmp
root@hquest:/tmp# du -s .
32      .
root@hquest:/tmp# _

Slackware-current install, stock kernel.

More info on demand, c/c me please. TIA.

-- 
dual_bereta_r0x -- Alexandre Hautequest
ArenaNetwork Lan House & Cyber -- www.arenanetwork.com.br
