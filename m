Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261483AbTCOSA3>; Sat, 15 Mar 2003 13:00:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261482AbTCOSA3>; Sat, 15 Mar 2003 13:00:29 -0500
Received: from smtp017.mail.yahoo.com ([216.136.174.114]:39942 "HELO
	smtp017.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S261483AbTCOSA2>; Sat, 15 Mar 2003 13:00:28 -0500
Subject: Re: Cisco Aironet 340 oops with 2.4.20
From: Thomas Hood <jdthood0@yahoo.co.uk>
To: linux-kernel@vger.kernel.org
Cc: achirica@users.sourceforge.net
Content-Type: text/plain
Organization: 
Message-Id: <1047751880.4798.4.camel@thanatos>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 15 Mar 2003 19:11:20 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Javier Achirica wrote:
> I have updated the CVS (airo-linux.sf.net) with a version that
> correctly implementes locking (there was a bug there). Please
> test it and tell me if it still panics.

The 2.4.19 - 2.4.20 airo driver was giving me the infamous
skb_free() related oops every few days, usually after I
downloaded something big.

2.4.21-pre5 with the airo driver from airo-linux.sf.net has
been running perfectly for four days now.  Looks good.

-- 
Thomas Hood <jdthood0@yahoo.co.uk>

__________________________________________________
Do You Yahoo!?
Everything you'll ever need on one web page
from News and Sport to Email and Music Charts
http://uk.my.yahoo.com
