Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130999AbQLLL1n>; Tue, 12 Dec 2000 06:27:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131265AbQLLL1d>; Tue, 12 Dec 2000 06:27:33 -0500
Received: from maidme.lnk.telstra.net ([139.130.75.195]:47876 "EHLO
	mail.maidment.com.au") by vger.kernel.org with ESMTP
	id <S130999AbQLLL11>; Tue, 12 Dec 2000 06:27:27 -0500
Message-ID: <3A36045E.E40E31FF@maidment.com.au>
Date: Tue, 12 Dec 2000 21:56:30 +1100
From: Bill Maidment <bill@maidment.com.au>
Organization: Maidment Enterprises
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test12 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: linux-2.4.0-test12 problem with init
In-Reply-To: <20001130110840.A2612@in.tum.de> <3A26FE24.80304@megapathdsl.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@pop.zip.com.au
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I reported a problem with using 'init 1' with 2.4.0-test12-pre8 and was
told it wasn't a kernel problem. I beg to differ, as it still happens
with 2.4.0-test12 but not with 2.4.0-test12-pre7. What changed between
pre7 and pre8 to make 'init 1' behave like 'init 5'? 'init 3' works
correctly. The only change I've made is to build the new kernel.

The screen messages say it is going into single user mode, but it just
doesn't.

Have I missed something that should be changed in the configuration?

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
