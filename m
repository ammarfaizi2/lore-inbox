Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270347AbRIALOU>; Sat, 1 Sep 2001 07:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270386AbRIALOL>; Sat, 1 Sep 2001 07:14:11 -0400
Received: from imo-m04.mx.aol.com ([64.12.136.7]:34261 "EHLO
	imo-m04.mx.aol.com") by vger.kernel.org with ESMTP
	id <S270347AbRIALOE>; Sat, 1 Sep 2001 07:14:04 -0400
From: Floydsmith@aol.com
Message-ID: <139.f2cc6d.28c21ce3@aol.com>
Date: Sat, 1 Sep 2001 07:13:39 EDT
Subject: I am confused about which cc patches need to be applied to reach level ac4
To: J.A.K.Mouw@its.tudelft.nl, linux-kernel@vger.kernel.org
CC: Floydsmith@aol.com
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: AOL 4.0 for Windows 95 sub 14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>On Sat, Sep 01, 2001 at 05:20:57AM -0400, Floydsmith@aol.com wrot
>> i-ac4 fixes the "can't mount ls-120 diskette (with diskette in drive)" 
>> problem (2.4.9) error:
>> ide-floppy: hdc: I/O error, pc = 5a, key  5, asc = 24, ascq =  0
>> then I need to get this patch. I would prepare to have a ftp URL site 
>> (preferably in the US) that has all of the ac patches (not just the ones 
for 
>> "ide") if such a site exists.

>ftp://ftp.us.kernel.org/pub/linux/kernel/people/alan/linux-2.4/


>Erik

Under the URL there are patches in 2.4.9 for ac1 to ac5. I am currently at 
2.4.9. In order to get to ac4, do I have to apply ac1 to 4 (in that order) or 
can I just apply ac4 (to get to ac4) or just ac5 (to get to ac5 with ac4 
automatically included). That is, are these independent patches (for 
different parts of the kernel) or, are they all for "ide" with each 
containing all preceeding ones.

Floyd,
