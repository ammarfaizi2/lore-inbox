Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281024AbRKTLkM>; Tue, 20 Nov 2001 06:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281029AbRKTLkB>; Tue, 20 Nov 2001 06:40:01 -0500
Received: from mailhost.iitb.ac.in ([203.197.74.142]:27664 "HELO
	mailhost.iitb.ac.in") by vger.kernel.org with SMTP
	id <S281028AbRKTLjn>; Tue, 20 Nov 2001 06:39:43 -0500
Date: Tue, 20 Nov 2001 17:04:58 +0530
From: N S S Kishore K <kishore@cse.iitb.ac.in>
To: linux-kernel@vger.kernel.org
Subject: write_lock_bh()
Message-ID: <20011120170458.A24330@cse.iitb.ac.in>
Reply-To: N S S Kishore K <kishore@cse.iitb.ac.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
X-Useless-Header: ??? # sign! 
X-Operating-System: SunOS chandra 5.6 Generic_105181-11 sun4u sparc
Organization: Dept. of Computer Science and Engineering, IIT Bombay
X-Url: http://www.cse.iitb.ac.in/~kishore
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi
	Can I call write_lock_bh() on a different lock, from a routine
which already called write_lock_bh() on another lock?

-kishore

-- 

