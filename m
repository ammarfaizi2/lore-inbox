Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278924AbRJVVIK>; Mon, 22 Oct 2001 17:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278930AbRJVVIB>; Mon, 22 Oct 2001 17:08:01 -0400
Received: from host2.in.gov ([199.8.101.18]:52026 "EHLO bart.ai.org")
	by vger.kernel.org with ESMTP id <S278924AbRJVVHx>;
	Mon, 22 Oct 2001 17:07:53 -0400
X-Recipient: <linux-kernel@vger.kernel.org>
Message-ID: <3BD48BAD.4936C0E6@www.IN.gov>
Date: Mon, 22 Oct 2001 16:12:13 -0500
From: Greg Swallow <gswallow@www.IN.gov>
Reply-To: gswallow@www.IN.gov
Organization: Access Indiana
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.2.17 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: rtl8139 drivers
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I just installed linux on a box with a builtin Realtek 8139 chipset. 
Using the 8139too.o module caused all kinds of performance problems, and
there are  suspicious statements in the 8139too.txt file:

THIS DRIVER IS A DEVELOPMENT RELEASE FOR A DEVELOPMENT KERNEL.  DO NOT
USE IN A PRODUCTION ENVIRONMENT.

However, I've used Donald Becker's rtl8139 driver in the past without
issues, and I'm using them now with v2.4.10.  I would like to request
that the stable code go back in place, please -- perhaps users can
choose between rtl8139 and 8139too?

Thanks!

-- "There's nothing that the proper funk cannot render funkable" -
+--------------+--------------------+---------------+-- G. Clinton +
| Greg Swallow | Assistant Sysadmin | accessIndiana | 888.4IN.EGOV |
+--------------+--------------------+---------------+----(446.3468)+
