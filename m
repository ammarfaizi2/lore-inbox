Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261492AbTIMQxL (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Sep 2003 12:53:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261512AbTIMQxL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Sep 2003 12:53:11 -0400
Received: from mx04.covadmail.net ([63.65.120.64]:53409 "HELO
	smtp.covadmail.net") by vger.kernel.org with SMTP id S261492AbTIMQxJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Sep 2003 12:53:09 -0400
Message-ID: <3F634B74.1010505@txrx.org>
Date: Sat, 13 Sep 2003 11:53:08 -0500
From: Chris Brookes <chris@txrx.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030903 Thunderbird/0.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: cramfs initrd functionality for 2.6?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anyone have plans to port the cramfs initrd feature from 2.4.22 into the 
2.6 series? I tried porting the (trivial looking) patches myself, even 
getting as far as the cramfs being recognised and the ramdisk filled, 
but ultimately lack of C and kernel knowledge is beating me..

Chris

