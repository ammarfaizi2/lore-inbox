Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136597AbREJNvE>; Thu, 10 May 2001 09:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136600AbREJNuz>; Thu, 10 May 2001 09:50:55 -0400
Received: from server5.safepages.com ([216.127.146.2]:15623 "HELO
	server5.safepages.com") by vger.kernel.org with SMTP
	id <S136597AbREJNul>; Thu, 10 May 2001 09:50:41 -0400
Message-ID: <3AFA9BC3.1060207@surfbest.net>
Date: Thu, 10 May 2001 08:46:43 -0500
From: Moses McKnight <m_mcknight@surfbest.net>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.3-ac13 i686; en-US; rv:0.9) Gecko/20010505
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.4-ac6 compile error in plip.c
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I get the following error trying to compile 2.4.4-ac6 using gcc 
2.95.4 (debian package).

plip.c:1412: __setup_str_plip_setup causes a section type conflict

