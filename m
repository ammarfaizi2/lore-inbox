Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbUKQJX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbUKQJX0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 04:23:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbUKQJX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 04:23:26 -0500
Received: from fep01fe.ttnet.net.tr ([212.156.4.130]:36589 "EHLO
	fep01.ttnet.net.tr") by vger.kernel.org with ESMTP id S262245AbUKQJW7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 04:22:59 -0500
Message-ID: <419B1813.80002@ttnet.net.tr>
Date: Wed, 17 Nov 2004 11:21:23 +0200
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.3) Gecko/20041003
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: marcelo.tosatti@cyclades.com
Subject: Re: Linux 2.4.28-rc4
Content-Type: text/plain; charset=ISO-8859-9; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Jakub Jelínek:
>   o binfmt_elf: handle p_filesz == 0 on PT_INTERP section

Another FYI: There were two successive binfmt_elf 2.6-backports posted
by Barry Nathan here;  "ELF fixes for executables with huge BSS":

http://marc.theaimsgroup.com/?t=109850369800001&r=1&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=109850420711579&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=109850420729735&w=2

but it may be too late for 2.4.28.

Ozkan Sezer


