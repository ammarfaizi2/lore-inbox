Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131142AbQKJPPy>; Fri, 10 Nov 2000 10:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131103AbQKJPPo>; Fri, 10 Nov 2000 10:15:44 -0500
Received: from iitg.ernet.in ([202.141.80.2]:48399 "EHLO luit.iitg.ernet.in")
	by vger.kernel.org with ESMTP id <S131151AbQKJPPd>;
	Fri, 10 Nov 2000 10:15:33 -0500
Date: Fri, 10 Nov 2000 20:33:29 +0530 (IST)
From: "M.Kiran Babu" <kbabu@iitg.ernet.in>
To: linux-kernel@vger.kernel.org
Subject: threads
Message-ID: <Pine.LNX.4.10.10011102031210.31929-100000@kamrup.iitg.ernet.in>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 sir,
i got some doubts in kernel
programming. i am using linux 6.1 version. i want to use threads in
kernel.is it possible to use pthreads in kernel. there is one more
function kernel_thread. can i use
that function. if i use that function how to get synchonization. inmany
files it was used. but everywhere lock_kernel() and unlock_kernel()
functions are being used. if we use that commands the whole kernel gets
locked. is there any other mechanisms. or can i use that methods only. if
i can use these methods what is the syntax of kernel_thread function. the
arguments that are passing to these function are 3. i dont know what are
those three. please  tell me.
				




                                               
                        
               




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
