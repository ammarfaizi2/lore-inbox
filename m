Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261413AbULXS0r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261413AbULXS0r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 13:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261424AbULXS0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 13:26:47 -0500
Received: from web51505.mail.yahoo.com ([206.190.38.197]:35684 "HELO
	web51505.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261413AbULXS0a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 13:26:30 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=ClVnDf8wW9M36viboMfJFR7I1Y7p1Vk4fBkckV3gztiS4oT7paxSakpbFVBNQVGdBT7MuhtQIERAMyXkq8IS5mv5hHiHtuc+Vfw3Y/0ChUvVdesGRaCM1Hl5nEwNw6pFtJJg1mE9LI2NdCAGmBNPs3WvGzmqhdE3ETdXgl6e/2s=  ;
Message-ID: <20041224182626.64273.qmail@web51505.mail.yahoo.com>
Date: Fri, 24 Dec 2004 10:26:26 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: About security field in struct sk_buff
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  In struct sk_buff (which is in the file
include/linux/skbuff.h), we can see the field unsigned
short security. I know its a security field for LSM,
and it says it is for security level of packet.
  Here, What does the security level of packet refer
to? Is it specified to a particular security model
(such as BLP)? and How can we use this field?

  Thank you.


=====
Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
Send a seasonal email greeting and help others. Do good. 
http://celebrity.mail.yahoo.com
