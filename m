Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263196AbUKUDSx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263196AbUKUDSx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 22:18:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263206AbUKUDSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Nov 2004 22:18:53 -0500
Received: from web41415.mail.yahoo.com ([66.218.93.81]:42918 "HELO
	web41415.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263195AbUKUDSu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Nov 2004 22:18:50 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=R8wlmxQrXjDIgisQG+4KxqMFFynRNuIMaMhGccAkyeIM9aq5YQ+L3YSAoDtYy/Sl9EHQZAlyji0MSzjLYeStSHAEB5l0Ym0nWd/a670YrNW0H9tfRMVqsr5nlLq0DFiHcHaXetwPGr8IALG19QPJ3oQiaMCPnWYW2o+u+U4nwk4=  ;
Message-ID: <20041121031849.95509.qmail@web41415.mail.yahoo.com>
Date: Sat, 20 Nov 2004 19:18:49 -0800 (PST)
From: cranium2003 <cranium2003@yahoo.com>
Subject: can netfilter help me.....
To: linux-kernel@vger.kernel.org
Cc: linux-net@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
       For adding new header in packet, can it be
possible for me to use netfilter to add my own header
in between ip and ethernet header? 
can anybody please help to how can i use netfilter
hooks to add new header?
can netfilter also allow me to change its
identification as ETH_IP to ETH_MY_IP?
regrads,
cranium.


		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 

