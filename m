Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261775AbULGHMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261775AbULGHMt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 02:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261776AbULGHMt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 02:12:49 -0500
Received: from web41406.mail.yahoo.com ([66.218.93.72]:40028 "HELO
	web41406.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261775AbULGHMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 02:12:47 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=CChQ/6gVsZl9yzowoy98xdKsCVe+zB0X+pcHD5ptnc5pXsrcSU16e9QrcMRLNHZbGjhhP2Zn9knX5NpXGS+7bhVbVWj982o5vPZ++qr4eQRcngqYqG/7SJbrTcdrogxK/24zzmAurytjsvgZXLZxmOevJH1IdFUVJmdxyaafNdU=  ;
Message-ID: <20041207071246.96973.qmail@web41406.mail.yahoo.com>
Date: Mon, 6 Dec 2004 23:12:46 -0800 (PST)
From: cranium2003 <cranium2003@yahoo.com>
Subject: Help in writing network device driver
To: kernerl mail <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello,
I am writing a virtual network device driver in which
i am setting hard_header 22 instead 14. i have some
queries about it.
1) is that thing possible (hard_header=22)?
2) does virtual device driver can take eth0 control
and send modified packets?
3) i want to send extra info with packets by making
hard header 22 so is there any alignement problem?
any other solution/help is welcome.
regards,
cranium




		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 

