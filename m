Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290818AbSDAApG>; Sun, 31 Mar 2002 19:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291787AbSDAAo4>; Sun, 31 Mar 2002 19:44:56 -0500
Received: from as2-4-6.am.g.bonet.se ([194.236.50.239]:34439 "HELO
	sunni.bumby.net") by vger.kernel.org with SMTP id <S290818AbSDAAok>;
	Sun, 31 Mar 2002 19:44:40 -0500
Date: Mon, 1 Apr 2002 01:47:43 +0200
From: niklas <niklas@bumby.net>
To: linux-kernel@vger.kernel.org
Subject: 2.4.18-xfs and the preemptive patch
Message-Id: <20020401014743.42630286.niklas@bumby.net>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just installed the preemptive ( http://www.tech9.net/rml/linux/ ----  preempt-kernel-rml-2.4.18-4 )  patch on my 2.4.18-xfs tree and when i run this kernel, every process ends with "exited with preempt_count 1" ( for example "rc.2[35] exited with preempt_count 1" )
The number varies from 1 to 41 so far.
Is this a known issue that there is a fix to, or is it just a misconfigured syslog?

Please CC the answer to me as i don't subscribe to the mailing list.

//niklas
niklas@bumby.net

