Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262107AbULaPXX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262107AbULaPXX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 10:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbULaPXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 10:23:23 -0500
Received: from web51507.mail.yahoo.com ([206.190.38.199]:45200 "HELO
	web51507.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262107AbULaPXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 10:23:19 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=hB4H9NWjQXxxAsOITU0ElvXI2ZqMDdC6KufDNkoFsHtESX1Oid5ce/dpR+Jmzv3A2l21bB97FHYndcsc7FPE/QJbF3L7/BiQUWi+QXw/xe04HBqUKhk6mHHL4a+hVIJajX6351h+aOm6lcmoQEWldtjm5zWU7SPY4C+FDLPti5U=  ;
Message-ID: <20041231152319.46687.qmail@web51507.mail.yahoo.com>
Date: Fri, 31 Dec 2004 07:23:19 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Issue on ip_route_output_key() and ip_route_output_flow()
To: netdev@oss.sgi.com
Cc: linux-kernel@vger.kernel.org, Linus.Torvalds@helsinki.fi,
       gw4pts@gw4pts.ampr.org, bir7@leland.Stanford.Edu, kuznet@ms2.inr.ac.ru,
       waltje@uWalt.NL.Mugnet.ORG
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  In /usr/src/linux/net/ipv4/route.c, there are two
functions, one is ip_route_output_key(), the other is
ip_route_output_flow(). Would you please tell me what
circumstances those two function are used for? and
What the difference between the two functions is? 
  As for ip_route_output_key() here, what is the
meaning of the "_key" in its name?

  Thank you.


=====
Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
All your favorites on one personal page – Try My Yahoo!
http://my.yahoo.com 
