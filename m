Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbVLZQWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbVLZQWU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 11:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932066AbVLZQWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 11:22:20 -0500
Received: from web53704.mail.yahoo.com ([206.190.37.25]:49297 "HELO
	web53704.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750898AbVLZQWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 11:22:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=pG9NVNZvDcf02rca8Jm31AWtxRzjqvuf2C7G39y8BA96lvLGFNwK7x5VZcRg7Asszey0na2/vxBvJt2K65y/r4PhXHU8Bg07tFD/G08fBSt96/LMvCByi66mSjpnnM0u4+Oo164aW6yHR226YWioAhjOfqbAUyxE4QPFsnPOKPA=  ;
Message-ID: <20051226162218.78162.qmail@web53704.mail.yahoo.com>
Date: Mon, 26 Dec 2005 08:22:18 -0800 (PST)
From: Mikado <mikado4vn@yahoo.com>
Subject: How to obtain process ID that created a packet
To: linux-kernel@vger.kernel.org, linux-c-programming@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Is there any way to catch REAL pid that generated a packet from 'struct sk_buff', 'struct sock',
'struct socket',
'struct file' or etc... ? direct/indirect ways are accepted.

Thank you!


	
		
__________________________________ 
Yahoo! for Good - Make a difference this year. 
http://brand.yahoo.com/cybergivingweek2005/
