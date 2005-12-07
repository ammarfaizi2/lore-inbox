Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750808AbVLGK0A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750808AbVLGK0A (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 05:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVLGKZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 05:25:37 -0500
Received: from xproxy.gmail.com ([66.249.82.195]:32714 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750801AbVLGKZd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 05:25:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Fkz5vsYr6CNm77YsLuA1hb/0PCFi9PcWUd2eJdhOxfD7Y9zpxw4AcaRLsk/VBT+es2+tQTF9hKrFVfGNgfe/S2aXdtkzmMDwaZrC++BdijSKyB4+d/4QClESL9TgN+MQ2l70B7gzpxZ6oztNZaqVlF7i7RqMjhDhL/aPXrt8mh0=
Message-ID: <993d182d0512070225kbc4d926w5ab4255e4cdaea75@mail.gmail.com>
Date: Wed, 7 Dec 2005 15:55:32 +0530
From: Conio sandiago <coniodiago@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Urgent work ! please help
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all
i am conio,
i am facing some problems.
I have a embedded monta vista linux kernel running on arm processor,
the linux kernel version is 2.6.x
I have developed a ethernet driver for the same.
But now i am facing a strange problems-

1) If i do a ftp for a very big file from one board to another pc
using a switching hub then

At an early stage ftp-data is normally sent to LinuxPC. Then suddenly
the embedded linux  asks the IP address of LinuxPC with using ARP.
After this point it start taking a lot of time to transfer data with
ftp command.

The packet analysis  shows there are  errors ,"TCP CHECKSUM INCORRECT".


Please help
if somebody has some idea
whether it can be a hardware / software bug???
Regards
conio
