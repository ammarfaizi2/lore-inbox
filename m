Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312903AbSDBTbR>; Tue, 2 Apr 2002 14:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312901AbSDBTbH>; Tue, 2 Apr 2002 14:31:07 -0500
Received: from relay1.pair.com ([209.68.1.20]:62731 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id <S312899AbSDBTbB>;
	Tue, 2 Apr 2002 14:31:01 -0500
X-pair-Authenticated: 24.126.75.99
Message-ID: <3CAA09E0.6549FD7F@kegel.com>
Date: Tue, 02 Apr 2002 11:43:28 -0800
From: Dan Kegel <dank@kegel.com>
Reply-To: dank@kegel.com
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Chris Friesen <cfriesen@nortelnetworks.com>
Subject: re: any problems with gcc 3.0/3.1 and compiling 2.4.18 on ppc?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen <cfriesen@nortelnetworks.com> wrote:
> We're looking at moving to gcc 3.x for 2.4.18, and are trying to decide what
> version to use.  It appears that there were some ppc-specific fixes that went in
> to 3.1, and I'm not sure if they were ported back to 3.0.
> 
> Has anyone had any successes or failures using either of these versions on ppc? 
> Any gotchas?

I'm about to do the same thing.  I'm already using a (patched) gcc3.0.2
on sh4, and really want to drop gcc2.9x for ppc, too.  Haven't tried
it yet, though.

Have you asked on linuxppc-{dev,user}@lists.linuxppc.org yet?
(Archives at http://lists.linuxppc.org/ )
- Dan
