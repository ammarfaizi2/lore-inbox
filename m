Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261570AbULBJof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbULBJof (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Dec 2004 04:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbULBJof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Dec 2004 04:44:35 -0500
Received: from web41411.mail.yahoo.com ([66.218.93.77]:15769 "HELO
	web41411.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261570AbULBJoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Dec 2004 04:44:34 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=k92BT0y43RKYSYKMggOHP5GR4uBRRgWyRcOAX5JmqyP/9qc7ObXyWrE7P9ymSzL+66OC8Ent972edeO7XCBfxbGmHyDKsnRKOhZZP1xOKL0zYIpVe3+rRwO6a4AMd3PpgkzKY/dpAceYFejgq5HEi0RIiLQRnYBcF1ypdL5sjWo=  ;
Message-ID: <20041202094433.39132.qmail@web41411.mail.yahoo.com>
Date: Thu, 2 Dec 2004 01:44:33 -0800 (PST)
From: cranium2003 <cranium2003@yahoo.com>
Subject: Maximum packet size in kernel
To: kernerl mail <linux-kernel@vger.kernel.org>
Cc: net dev <netdev@oss.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
I want to know how much maximum packet size is
assigned by alloc_skb in kernel? and is there any
extra space remains in packet allocated memory?
Does it dependent on CPU cache?
regards,
cranium.



		
__________________________________ 
Do you Yahoo!? 
The all-new My Yahoo! - What will yours do?
http://my.yahoo.com 
