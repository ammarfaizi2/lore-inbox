Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314277AbSD0Q3N>; Sat, 27 Apr 2002 12:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314278AbSD0Q3M>; Sat, 27 Apr 2002 12:29:12 -0400
Received: from gherkin.frus.com ([192.158.254.49]:13697 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S314277AbSD0Q3M>;
	Sat, 27 Apr 2002 12:29:12 -0400
Message-Id: <m171V4A-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: Re: The tainted message
In-Reply-To: <E171TzX-0008PF-00@the-village.bc.nu> "from Alan Cox at Apr 27,
 2002 04:20:03 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Sat, 27 Apr 2002 11:28:54 -0500 (CDT)
CC: linux-kernel@vger.kernel.org
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > I would like to propose that a clearer, more direct message be used. 
> > Something like "Warning: kernel maintainers may not support your kernel
> > since you have loaded %s: %s%s\n" would be much more informative and
> > correct.
> 
> More informative but I think too soft. It still implies we might want to
> hear about it but not reply. That isnt the case.

What you say is true enough if you speak for yourself and/or the core
cadre of kernel maintainers.  On the other hand, the linux-kernel list
has been and mostly continues to be a good place to get help with
problems related to kernel changes that affect non-GPL modules.

To put it another way, the kernel developers aren't necessarily the
target audience when a request for assistance is posted to linux-kernel.
If that was too subtle, kernel developers aren't the only people who
read linux-kernel.  Is linux-kernel an appropriate venue for such
assistance requests?  Maybe not the *most* appropriate one, but it's
often the most efficient.  Let me put it this way: speaking for myself,
I don't ask linux-kernel list readers for help with a problem if the
problem isn't the immediate result of a kernel change.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
