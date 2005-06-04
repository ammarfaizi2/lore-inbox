Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbVFDCsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbVFDCsd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 22:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVFDCsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 22:48:33 -0400
Received: from web14824.mail.yahoo.com ([216.136.225.195]:6738 "HELO
	web14824.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261225AbVFDCsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 22:48:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=b2zjjuuDoNoAVqrMZhNw3XExOmbLC1pdykEUYJtm7qys1BWN16EyDtt3Aa0UVQdEgQBFtrZPjDht2wQez6qJXsjHIJLsWi5qOENDlEMjzuSRP9Xa2aJPET2IwlN5CAyOn0dbxNepYpeErAIjF+1rHS+MbguZUyvT/lbKNreVbOE=  ;
Message-ID: <20050604024830.13002.qmail@web14824.mail.yahoo.com>
Date: Fri, 3 Jun 2005 19:48:30 -0700 (PDT)
From: Ananda Krishnan <veedutwo@yahoo.com>
Subject: device-driver supporting more than one device
To: linux-kernel@vger.kernel.org
Cc: veedutwous@yahoo.com
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

  Can a device-driver (a generic serial driver)
support more than one device from different vendors
(hence different vendor ids and device ids)? If so,
during the boot time how the pci_device_id structure
gets the info about the drvier_data?  Would like to
know the name of the function name(s) and file(s) that
are used for this process.  Thanks a lot.

Ananda Krishnan


		
__________________________________ 
Discover Yahoo! 
Get on-the-go sports scores, stock quotes, news and more. Check it out! 
http://discover.yahoo.com/mobile.html
