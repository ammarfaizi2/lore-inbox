Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751247AbVL3LMG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751247AbVL3LMG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 06:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751252AbVL3LMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 06:12:06 -0500
Received: from web54105.mail.yahoo.com ([206.190.37.240]:24753 "HELO
	web54105.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751247AbVL3LMF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 06:12:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=W8nc4OGsW7VN6VJS3I7xfOl8eQSEBlx63QykVKAi7C2I1AuSX0oz4jqIzH2NtUdqkOmvLnlBrt5dkaOxhmFj9NpDxFpUfE9Fnm+KbYRAksCAr1MNzrTxMvZJPBnbKHJ2TqDho5OjZi8QfRje9lSlcijQtC/8XCYtfzkb3873YXA=  ;
Message-ID: <20051230111204.11157.qmail@web54105.mail.yahoo.com>
Date: Fri, 30 Dec 2005 03:12:04 -0800 (PST)
From: sundar <sundar_draj@yahoo.com>
Subject: [pci driver model] communication from user application
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello All,

I plan to write the PCI driver based on “PCI driver
model”.  

I understand that I have to populate the pci_driver
and pci_device_id structures with the required driver
routines and device information for dyanamic loading
of device. 

But I could not understand how the user level
application can open the device and communicate with
the driver through ioctls.  I dont   know how I can
populate the ioctl routine in pci driver like
file_operations structure in char driver.

Please le me know the pointers regarding this. 

Thanks,
Sundar Raj




	
		
__________________________________ 
Yahoo! for Good - Make a difference this year. 
http://brand.yahoo.com/cybergivingweek2005/
