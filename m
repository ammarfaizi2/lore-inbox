Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750971AbVH3Gxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971AbVH3Gxr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 02:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751045AbVH3Gxq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 02:53:46 -0400
Received: from web51807.mail.yahoo.com ([206.190.38.238]:14224 "HELO
	web51807.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750971AbVH3Gxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 02:53:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=FNthXYcLND3Gv+e1U1C1uSjG6IowaW9QA4iophy37J9M3pFVA9l4qUYLki3yktCfz6R4ujm5zduY+s+JyHaM7j/joevOsyBXH0TKCybsLQUUmc28hQe7uVA8KVVw5nZaCQrRfmT+1tey5s0KZSOPDJDj6YepTE6Ka2IBhWk6W6k=  ;
Message-ID: <20050830065344.86508.qmail@web51807.mail.yahoo.com>
Date: Mon, 29 Aug 2005 23:53:44 -0700 (PDT)
From: Phy Prabab <phyprabab@yahoo.com>
Subject: odd socket behavior
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I am seeing something odd w/sockets.  I have an app
that opens and closes network sockets.  When the app
terminates it releases all fd (sockets) and exists,
yet running netstat after the app terminates still
shows the sockets as open!  Am I doing something wrong
or is this something that is normal?

TIA!
Phy

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
