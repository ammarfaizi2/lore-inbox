Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277203AbRJ3SJ4>; Tue, 30 Oct 2001 13:09:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277152AbRJ3SJq>; Tue, 30 Oct 2001 13:09:46 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:6153 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S277317AbRJ3SJ2>; Tue, 30 Oct 2001 13:09:28 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15326.60536.561925.749776@beta.reiserfs.com>
Date: Tue, 30 Oct 2001 21:07:52 +0300
To: "P.Agenbag" <internet@psimation.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.13 kernel and ext3???
In-Reply-To: <3BDEE870.1060104@psimation.com>
In-Reply-To: <3BDEE870.1060104@psimation.com>
X-Mailer: VM 6.89 under 21.4 (patch 3) "Academic Rigor" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P.Agenbag writes:
 > Hi
 > I just installed RedHat 7.2 with the 2.4.7 kernel. Low and behold, when 
 > I tried to install the latest kernels, I see that there are many options 
 > in the RedHat 2.4.7 kernel that are not even in the 2.4.13 kernel! How 
 > does this work? Also, I see many (EXPERIMENTAL) greyd-out areas in the 
 > kernel as well as other greyd out areas which are not experimental, yet 
 > won't allow me to select it ( reiserfs for example ) .
 > How can I get reiserfs to compile into the kernel, and to satsify my 
 > curiosity, how do you enable the experimental options?

Turn on first option "Prompt for development and/or incomplete
code/drivers" in the first configuration sub-menu "Code maturity level
options".

Read namesys.com/faq.html

 > 
 > Does it mean that if there is a fairly large difference between the 
 > RedHat 2.4.7 and the stock one from kernel.org, that they are not really 
 > the same? ie, does anyone foresee any future problems with redhat adding 
 > all these extra features to their kernel and people who would like to 
 > upgrade to a newer version ( for one, I selected ext3 during install, 
 > yet, now trying to install 2.4.13, I must revert back to ext2...)
 > 
 > Thanks

Nikita.

 > 
 > 
