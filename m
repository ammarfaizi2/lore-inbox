Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750757AbVIPXCS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750757AbVIPXCS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 19:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750758AbVIPXCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 19:02:18 -0400
Received: from zproxy.gmail.com ([64.233.162.196]:60076 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750757AbVIPXCR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 19:02:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=nYCJOU7W9ESrqvHC0EA5klfU4OcLoIFf3WJ7NyHcrGqk1BNL3nnbAk2AG64jGapCX7WN9cK6NIMDr0lzYeWx0e7UQRjOHftk10fCACsaTzRnavOniL8wS6yE4IBLfHpKVcWH6LiA7tPZ5v+EJrmoYt+Qugciyw7jQQKExm595BA=
Message-ID: <40b4372005091616024e4dd9a3@mail.gmail.com>
Date: Fri, 16 Sep 2005 16:02:16 -0700
From: Simon Matthews <simon.d.matthews@gmail.com>
Reply-To: simon.d.matthews@gmail.com
To: linux-kernel@vger.kernel.org
Subject: Ethernet interface problem -- system lockup.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Firstly, sorry for cluttering your inboxes with an empty email. 

Can anyone comment on the messages that were in our logfiles  (see
below)? I can't find any similar error messages on the web or in
newsgroups.

The machine became unresponsive immediately after this. It would not
respond to either the network, or keyboard.

It is running a RedHat kernel 2.4.20 or similar. 

Sep 15 16:20:28 xxxx kernel: eth1: Error -- Rx packet size(8172) > mtu(1500)+14
Sep 15 16:20:28 xxxx kernel: eth1: Error -- Rx packet size(8172) > mtu(1500)+14
Sep 15 16:20:28 xxxx last message repeated 9 times
Sep 15 16:20:28 xxxx kernel: eth1: Error -- Rx packet size(4391) > mtu(1500)+14
Sep 15 16:21:19 xxxx last message repeated 8 times
Sep 15 16:21:19 xxxx kernel: eth1: Rx ERROR!!!
Sep 15 16:21:20 xxxx last message repeated 31 times
Sep 15 16:21:20 xxxx kernel: !!!
Sep 15 16:21:20 xxxx kernel: !!!
Sep 15 16:21:20 xxxx kernel: eth1: Rx ERR!!!
Sep 15 16:21:20 xxxx kernel: eth1: Rx ERR!!!
Sep 15 16:21:20 xxxx kernel: eth1: Rx ERRO!!!
Sep 15 16:21:20 xxxx kernel: eth1: Rx ERRO!!!
Sep 15 16:21:20 xxxx kernel: eth1: Rx ERR!!!

Best Regards,
Simon Matthews
