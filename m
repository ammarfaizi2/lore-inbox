Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266298AbTBQDWR>; Sun, 16 Feb 2003 22:22:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266330AbTBQDWR>; Sun, 16 Feb 2003 22:22:17 -0500
Received: from manchaca.ece.utexas.edu ([128.83.59.38]:138 "EHLO
	manchaca.ece.utexas.edu") by vger.kernel.org with ESMTP
	id <S266298AbTBQDWQ>; Sun, 16 Feb 2003 22:22:16 -0500
Message-ID: <3E5057A7.80909@ece.utexas.edu>
Date: Sun, 16 Feb 2003 21:31:51 -0600
From: yi <yi@ece.utexas.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: tcp window size
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guys,

I apologize for my naive question. However, I think it's good way to ask 
my question to linux-kernel gurus here.

Basically, I want to add a system call which return the window size of 
the corresponding tcp connection. It should have a parameter of socket 
descriptor. (Say, get_winsize( int sock ) )

My question is which in-kernel data structure has the window size value 
of the ongoing tcp connection and how can I get that value from the 
socket descriptor. Actually, the question is related with the linkage of 
data structures from the socket to the tcp window size.

If you know any link or documentation, please let me know.

Thanks in advance.

- Yung Yi.

