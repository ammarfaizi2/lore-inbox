Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262431AbUDZPM3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbUDZPM3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 11:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262425AbUDZPM3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 11:12:29 -0400
Received: from web41403.mail.yahoo.com ([66.218.93.69]:58961 "HELO
	web41403.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262208AbUDZPMZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 11:12:25 -0400
Message-ID: <20040426151220.85059.qmail@web41403.mail.yahoo.com>
Date: Mon, 26 Apr 2004 08:12:20 -0700 (PDT)
From: Parag Nemade <cranium2003@yahoo.com>
Subject: HELP ipt_hook: happy cracking message
To: kernerl mail <linux-kernel@vger.kernel.org>
Cc: netdev@oss.sgi.com, linux-net@vger.kernel.org,
       netfilter <netfilter-devel@lists.netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
        i modified kernel so that it will create
/proc/net/myproc file entry.
the function of this entry is to crate a 16 byte char
string from random no.s
i used net_srandom and net_random and sys_time for
that puspose. the problem is that i write program to
generate string after 120 seconds but it is changing
contents of myproc file every seconds. what can i do?
 Also i am getting ipt_hook: happy cracking. message
again and again why?
regards,
parag.


	
		
__________________________________
Do you Yahoo!?
Yahoo! Photos: High-quality 4x6 digital prints for 25¢
http://photos.yahoo.com/ph/print_splash
