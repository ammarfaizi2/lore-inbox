Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129531AbRBYSc5>; Sun, 25 Feb 2001 13:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129533AbRBYScs>; Sun, 25 Feb 2001 13:32:48 -0500
Received: from strider.inria.fr ([138.96.38.46]:19473 "EHLO strider.inria.fr")
	by vger.kernel.org with ESMTP id <S129531AbRBYScb>;
	Sun, 25 Feb 2001 13:32:31 -0500
Message-ID: <3A994FBC.691A143C@sophia.inria.fr>
Date: Sun, 25 Feb 2001 19:32:28 +0100
From: Fabrice Peix <Fabrice.Peix@sophia.inria.fr>
Organization: INRIA
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.14 i686)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: KML <linux-kernel@vger.kernel.org>
Subject: sched_yield
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




	Yop,

	Just a newbie question ...
	Why sys_sched_yield don't call schedule ?
	
	
	man page of sched_yield tell : 

	"A  process  can relinquish the processor voluntarily 
	without blocking by calling sched_yield.  
	The process will then be moved to the end 
	of the queue for its static priority and 
	a new process gets to run."
	
	Bye.
