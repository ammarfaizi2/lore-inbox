Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261296AbULWTqD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261296AbULWTqD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 14:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261301AbULWToh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 14:44:37 -0500
Received: from web51501.mail.yahoo.com ([206.190.38.193]:12905 "HELO
	web51501.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261293AbULWTj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 14:39:26 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=1/y6e9lat7w3fIYTkekCTVLxFBx98czcp82/gocPBFIHAnlO8bl53KcMZ0Tc3BzNeCSzF3qmTaQIOCjWGQRCNBJj5p71oO8S6DoyGqg7I/5U3VdxUPSU+9wRkxtkHj9zapjDYychqDzk6uWBS5iLMDZju5qyGBKopm6/JzwMbIg=  ;
Message-ID: <20041223193925.57234.qmail@web51501.mail.yahoo.com>
Date: Thu, 23 Dec 2004 11:39:25 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Something wrong when transform Documentation/DocBook/*.tmpl into pdf
To: twaugh@redhat.com
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  I'm using Fedora Core 2. In
/usr/src/linux-2.6.5-1.358/Documentation/kernel-doc-nano-HOWTO.txt,
in the 'How to extract the documentation' subsection,
it says:

If you just want to read the ready-made books on the
various subsystems (see Documentation/DocBook/*.tmpl),
just type 'make psdocs', or 'make pdfdocs', or 'make
htmldocs', depending on your preference.

  Then, on the command line, I type the following
commands:

cd /usr/src/linux-2.6.5-1.358/Documentation/DocBook 
<ENTER>
make pdfdocs  <ENTER>

  But the system says the following:

make: *** No rule to make target `scripts/kernel-doc',
needed by `/wanbook.sgml'.  Stop.

  Then, what's the matter? How actually can I
transform the *.tmpl in Documentation/DocBook into pdf
files? 

  Thank you.



=====
Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 

