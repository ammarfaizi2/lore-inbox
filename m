Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267726AbTBYTEN>; Tue, 25 Feb 2003 14:04:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267826AbTBYTEN>; Tue, 25 Feb 2003 14:04:13 -0500
Received: from phage.cshl.org ([143.48.1.1]:11139 "EHLO cshl.org")
	by vger.kernel.org with ESMTP id <S267726AbTBYTEM>;
	Tue, 25 Feb 2003 14:04:12 -0500
Message-ID: <3E5BC15D.7080603@cshl.edu>
Date: Tue, 25 Feb 2003 14:17:49 -0500
From: "Vsevolod (Simon) Ilyushchenko" <simonf@cshl.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3a) Gecko/20021212
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Per-process disk statistics? (a la top)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am looking for a way to find out which processes contribute the most 
to disk I/O (something like top, but for disk activity). There seems to 
be no way of doing this (sar, iostat and lsof are no good here), so I 
was wondering whether kernel provides this information at all.

I hope this is not considered offtopic - I don't know of any other forum 
pertinent to the question.

Thank you in advance for any pointers,
Simon
-- 

Simon (Vsevolod ILyushchenko)   simonf@cshl.edu
				http://www.simonf.com

"Large software projects are like werewolves because
they transform unexpectedly from the familiar into horrors."
                     Fred Brooks



