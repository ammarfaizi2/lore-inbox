Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276569AbRJKQru>; Thu, 11 Oct 2001 12:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276562AbRJKQrl>; Thu, 11 Oct 2001 12:47:41 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:22945 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S276576AbRJKQr2>; Thu, 11 Oct 2001 12:47:28 -0400
Message-ID: <3BC5CD56.2E69C578@nortelnetworks.com>
Date: Thu, 11 Oct 2001 12:48:22 -0400
From: "Christopher Friesen" <cfriesen@nortelnetworks.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-custom i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: unkillable process in R state?
In-Reply-To: <Pine.SOL.4.33.0110111645410.18253-100000@yellow.csi.cam.ac.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Orig: <cfriesen@nortelnetworks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have a process (an instance of a find command) that seems to be unkillable (ie
kill -9 <pid> as root doesn't work).

Top shows it's status as R.

Is there anything I can do to kill the thing? It's taking up all unused cpu
cycles (currently at 97.4%).

Thanks,

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10  
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com
