Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264256AbRFSO4j>; Tue, 19 Jun 2001 10:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264259AbRFSO43>; Tue, 19 Jun 2001 10:56:29 -0400
Received: from jalon.able.es ([212.97.163.2]:2946 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S264256AbRFSO4V>;
	Tue, 19 Jun 2001 10:56:21 -0400
Date: Tue, 19 Jun 2001 16:57:38 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Dan Kegel <dank@kegel.com>
Cc: jamagallon@able.es,
        "linux-kernel @ vger . kernel . org" <linux-kernel@vger.kernel.org>
Subject: Re: accounting for threads
Message-ID: <20010619165738.A16555@werewolf.able.es>
In-Reply-To: <3B2F6759.6CF96382@kegel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <3B2F6759.6CF96382@kegel.com>; from dank@kegel.com on Tue, Jun 19, 2001 at 16:53:13 +0200
X-Mailer: Balsa 1.1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 20010619 Dan Kegel wrote:
>
>Let me know if this helps.  And anyone else, let me know if there's a simpler
>way to do this.  Should LinuxThreads be doing this under the hood, so it can
>be a little closer to posix threads compliance?
>- Dan

He, I have just discovered that IRIX 6.2 times(2) also fails to account time for
threads. 6.4 works fine.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Linux Mandrake release 8.1 (Cooker) for i586
Linux werewolf 2.4.5-ac15 #2 SMP Sun Jun 17 02:12:45 CEST 2001 i686
