Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132547AbRDGEoW>; Sat, 7 Apr 2001 00:44:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132548AbRDGEoN>; Sat, 7 Apr 2001 00:44:13 -0400
Received: from ns1.justnet.com ([64.245.23.22]:40721 "EHLO ns1.justnet.com")
	by vger.kernel.org with ESMTP id <S132547AbRDGEny>;
	Sat, 7 Apr 2001 00:43:54 -0400
From: Lee Leahu <lee@ricis.com>
Reply-To: lee@ricis.com
Organization: RICIS Inc
To: linux-kernel@vger.kernel.org
Subject: module problem with new kernel
Date: Fri, 6 Apr 2001 23:42:37 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Message-Id: <01040623423705.00821@linux>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello everyone!

i recently installed suse 7.1 kernel 2.4.0-4GB on an IBM 600E laptop.
it runs execellent!
but i wanted to also have sound, so through make xconfig i added
the sound module, then i found out i had to enable reiserfs (that's what fs i use)
and pcmcia.
now it's complaining that it can't find the modules - suse installed the modules in
/usr/lib/modules/2.4.0-4GB and the new kernel is the plain 2.4.0 and is looking
in /usr/lib/modules/2.4.0

can i make a symling from 2.4.0 to 2.4.0-4GB or is there a twist in it?

is there a way i can tell from somewhere what all the options where used to complie the 
original kernel from suse where?

-- 
Lee Leahu <lee@ricis.com>,
System Admin,
Web Developer,
RICIS Inc,
(708) 444-2690 (Work)
(708) 467-2044 (Pager)
