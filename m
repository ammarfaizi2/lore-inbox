Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbUKWMuj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbUKWMuj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 07:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261201AbUKWMui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 07:50:38 -0500
Received: from web41411.mail.yahoo.com ([66.218.93.77]:13707 "HELO
	web41411.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261207AbUKWMu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 07:50:26 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=1QPlzeeGcWIws7qhze1T+lh+CnvX9ti1Jakw09uFbR3KBRDDVnZhPwxbrtTXe28sFSB8rfWLEUAiM0qLqwqs+YKrfdX8JksUFzf42O56eHewkRHx+QQR5Z1Yj5dbK4GiDGjavhQfBRI0XlaXfGMotxOmergf2v4NW98733yMEFQ=  ;
Message-ID: <20041123125021.69735.qmail@web41411.mail.yahoo.com>
Date: Tue, 23 Nov 2004 04:50:20 -0800 (PST)
From: cranium2003 <cranium2003@yahoo.com>
Subject: using skbuff in kernel module
To: netfilter devel <netfilter-devel@lists.samba.org>
Cc: kernerl mail <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
         I want to add new header between IP and
ETHERNET layer. I want to ask can it be done using
netfilter hooks? 
         Can skb functions (skb_reserve, skb_push
,skb_pull)be allowed to use in kernel module so that i
can add at NF_IP_LOCAL_OUT and pull my own header at
NF_IP_LOCAL_IN?

regards,
cranium


		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 

