Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265385AbSJaWBO>; Thu, 31 Oct 2002 17:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265387AbSJaWBN>; Thu, 31 Oct 2002 17:01:13 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:20209 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S265385AbSJaWBF>;
	Thu, 31 Oct 2002 17:01:05 -0500
Message-ID: <3DC1A983.7B5B12B2@mvista.com>
Date: Thu, 31 Oct 2002 14:06:59 -0800
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: lost messages
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just stepped over the line again with a message too long
for the lklm.  Am I the only one who would like a message
back when lklm drops a message?  The mail system seems to
say:
relay=vger.kernel.org. [209.116.70.75], 
stat=Sent (2.7.0 nothing apparently wrong in the message.;
S264820AbSJaKoJ)

and then drop the message.  Maybe, at least this response
could be changed.
-- 
George Anzinger   george@mvista.com
High-res-timers: 
http://sourceforge.net/projects/high-res-timers/
Preemption patch:
http://www.kernel.org/pub/linux/kernel/people/rml
