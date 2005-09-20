Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932735AbVITFU5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932735AbVITFU5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 01:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932734AbVITFU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 01:20:56 -0400
Received: from web35912.mail.mud.yahoo.com ([66.163.179.196]:53637 "HELO
	web35912.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932733AbVITFU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 01:20:56 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=QQZBEzn8hAmwC0kF3Wldf6PSs7rICACq7gY2QYlZF3vxCA5ATiSxcUWNNJPv7VK3V6veiX8qd2C98XXbRFVrQ88OiiPvfZBqHCAGw/wlLg3IqOae0uwwDQFWNv4C01Ujkm7BBFq7/9OKAyLOxz8zMo7bvowbU0cJEMidU6jw5IM=  ;
Message-ID: <20050920052055.87136.qmail@web35912.mail.mud.yahoo.com>
Date: Mon, 19 Sep 2005 22:20:55 -0700 (PDT)
From: umesh chandak <chandak_pict@yahoo.com>
Subject: about ioctl call for network device drivers.
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a atheros wireless driver.it's monitor mode
interface is ath0raw.I want to pass a some value to
this 
interface in kernel module.so i want to use ioctl
calls.
But i have  not found the any char device with name
ath0raw or something like that.
           What should i do? How should i use ioctl
calls for network devices. 


		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
