Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136092AbREJMAt>; Thu, 10 May 2001 08:00:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136084AbREJMAl>; Thu, 10 May 2001 08:00:41 -0400
Received: from zeus.kernel.org ([209.10.41.242]:61671 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S136082AbREJMAa>;
	Thu, 10 May 2001 08:00:30 -0400
To: linux-kernel@vger.kernel.org
Date: Thu, 10 May 2001 02:19:41 -0700
From: "sachin kitnawat" <sachin_76@lycos.com>
Message-ID: <NJMIGAKMNAMIKAAA@mailcity.com>
Mime-Version: 1.0
X-Sent-Mail: off
Reply-To: sachin_76@lycos.com
X-Mailer: MailCity Service
Subject: Linux thread problem
X-Sender-Ip: 216.6.80.59
Organization: Lycos Mail  (http://mail.lycos.com:80)
Content-Type: text/plain; charset=us-ascii
Content-Language: en
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi  All,
	
	I am porting an Threading Application from Hp-UX 11.0 
to Red Hat Linux 6.2. There is a system call pthread_condattr_setpshared 
and pthread_mutex_setpshared in HP-UX which is not available on Linux.
So please let me know how to implement the functionality of these 
funtions in Red Hat Linux 6.2. These functions are used to set the 
process shared attribute in a condition and mutex variable attributes
 object.

Thanks in Advance 
Sachin


Get 250 color business cards for FREE!
http://businesscards.lycos.com/vp/fastpath/
