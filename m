Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129314AbQLKJQt>; Mon, 11 Dec 2000 04:16:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129345AbQLKJQj>; Mon, 11 Dec 2000 04:16:39 -0500
Received: from maidme.lnk.telstra.net ([139.130.75.195]:58117 "EHLO
	mail.maidment.com.au") by vger.kernel.org with ESMTP
	id <S129314AbQLKJQ0>; Mon, 11 Dec 2000 04:16:26 -0500
Message-ID: <3A349435.7AB9272F@maidment.com.au>
Date: Mon, 11 Dec 2000 19:45:41 +1100
From: Bill Maidment <bill@maidment.com.au>
Organization: Maidment Enterprises
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Trouble with 2.4.0-test12-pre8
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I've had some very peculiar problems with 2.4.0-test12-pre8

In particular I can't start linux in single user mode, it goes to level
5 when trying to init 1.

There is also a problem building fs/smbfs/inode.c at line 166

Is there a fix or have I got something really screwed up?

-- 
Regards

Bill Maidment
Computer Systems Consultant

_________________________________________

      Maidment Enterprises Pty Ltd      
      42 Woy Woy Bay Road
      Woy Woy Bay  NSW  2256 
_________________________________________
                                         
  Home Phone 02 4342 6716                
  Work Phone 02 9927 3234                
  Mobile     0418 682 993                
  Home Email bill@maidment.com.au        
  Work Email bill.maidment@elgas.com.au  
  Web Page   www.maidment.com.au         
_________________________________________
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
