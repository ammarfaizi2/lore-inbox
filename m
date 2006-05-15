Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964917AbWEOOAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964917AbWEOOAx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 10:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964918AbWEOOAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 10:00:53 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:8163 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S964916AbWEOOAw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 10:00:52 -0400
Subject: RE: GPL and NON GPL version modules
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: "Nutan C." <nutanc@esntechnologies.co.in>
Cc: Steven Rostedt <rostedt@goodmis.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>,
       Fawad Lateef <fawadlateef@gmail.com>, jjoy@novell.com,
       "Mukund JB." <mukundjb@esntechnologies.co.in>, gauravd.chd@gmail.com,
       bulb@ucw.cz, greg@kroah.com, Shakthi Kannan <cyborg4k@yahoo.com>,
       "Srinivas G." <srinivasg@esntechnologies.co.in>
In-Reply-To: <AF63F67E8D577C4390B25443CBE3B9F7092952@esnmail.esntechnologies.co.in>
References: <AF63F67E8D577C4390B25443CBE3B9F7092952@esnmail.esntechnologies.co.in>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 15 May 2006 15:12:32 +0100
Message-Id: <1147702352.26686.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-4.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2006-05-15 at 19:04 +0530, Nutan C. wrote:
> 1. I developed a code which interfaces well with a proprietary OS. Now,
> somebody else feels to use the same module in his Linux Kernel. So, he
> comes up with a patch, which interfaces and talks to my module with my
> interfaces and then makes a release with the patch. And, I would have no
> idea of my module being really compatible/used in Linux Kernel. One fine
> day, I would get a mail saying that I need to make my code open source.
> What would be my reply?

Probably not polite

If someone takes your proprietary code and combines it with GPL code in
a way the GPL license prohibits then they not you are committing the
license violation (they are probably also violating your license as well
as the GPL license by doing so)

There are exceptions to that - one might be if you developed the code
and arranged for the person to do the merge with Linux rather than
someone else doing it. 

In the normal case of things I can combine two works only if the
licenses of the two works are compatible, that is effectively only if I
have permission from all parties who own rights on the resulting
"derivative" work.

Alan



