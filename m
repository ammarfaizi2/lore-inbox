Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262737AbVAKMNC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262737AbVAKMNC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 07:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbVAKMNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 07:13:02 -0500
Received: from web53306.mail.yahoo.com ([206.190.39.235]:17325 "HELO
	web53306.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262737AbVAKMMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 07:12:48 -0500
Message-ID: <20050111121248.67799.qmail@web53306.mail.yahoo.com>
Date: Tue, 11 Jan 2005 12:12:48 +0000 (GMT)
From: sounak chakraborty <sounakrin@yahoo.co.in>
Subject: syslog with syscall3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dear sir,
i am facing some problem when i want to retrieve the
lines of 

information from the log file i.e from
/var/log/messages
i am using syslog function with syscall3 macro.it is
showing the output 

correctly but whenever i am declaring the structures
of sockets it is 

showing segmentation fault 
how to correctt it 
is it so that my syscall 3 macro changing the program
to kernel mode 

and all the socket functions are not in or different
in kernel mode ?
then what will be the possible solution if i want t
retrieve the 

information from logfile and send it to a file.
thanks in advance 
sounak

________________________________________________________________________
Yahoo! India Matrimony: Find your partner online. http://yahoo.shaadi.com/india-matrimony/
