Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131270AbRCRUiu>; Sun, 18 Mar 2001 15:38:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131271AbRCRUil>; Sun, 18 Mar 2001 15:38:41 -0500
Received: from dsl-64-129-179-177.telocity.com ([64.129.179.177]:23308 "HELO
	mail.ovits.net") by vger.kernel.org with SMTP id <S131270AbRCRUid>;
	Sun, 18 Mar 2001 15:38:33 -0500
Date: Sun, 18 Mar 2001 13:37:18 -0500
From: Mordechai Ovits <movits@ovits.net>
To: linux-kernel@vger.kernel.org
Subject: tcp retransmit timeout?
Message-ID: <20010318133718.A30811@ovits.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
X-Satellite-Tracking: 0x4B305AFF
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How can I set the timeout for retransmitting non-acknowledged packets?  I'd
like to set linux up to more aggressive about assuming a packet didn't make
it.

Thanks!
Mordy
