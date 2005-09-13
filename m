Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751197AbVIMJU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbVIMJU4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 05:20:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751199AbVIMJU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 05:20:56 -0400
Received: from web8503.mail.in.yahoo.com ([202.43.219.165]:33654 "HELO
	web8503.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S1751197AbVIMJUz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 05:20:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=42iZCBzU435mynpC+V2CtqkupT3YXN2sNwmFqgctGBJm3nzAEFqr72T4cI42JYqJU5Uzh3KSpZjwuFFtBVo3fY9muI6onhEEaZAdu5WSrfPbxvyvTgpLZd5w83zYM800FVSLdGTlDQMBkkqbhyk/A/SEjli9JzUDK2HNwYoJpRw=  ;
Message-ID: <20050913092048.13490.qmail@web8503.mail.in.yahoo.com>
Date: Tue, 13 Sep 2005 10:20:48 +0100 (BST)
From: manomugdha biswas <manomugdhab@yahoo.co.in>
Subject: how to use wait_event_interruptible_timeout
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 
I was using interruptible_sleep_on_timeout() in kernel
2.4. In kernel 2.6 I have use
wait_event_interruptible_timeout. But it is now
working!!. interruptible_sleep_on_timeout() was
working fine. Could anyone please help me in this
regard.
Regards,
Mano

Manomugdha Biswas


		
__________________________________________________________ 
Yahoo! India Matrimony: Find your partner now. Go to http://yahoo.shaadi.com
