Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267856AbTAMFJ0>; Mon, 13 Jan 2003 00:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267855AbTAMFJ0>; Mon, 13 Jan 2003 00:09:26 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:6573 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id <S267856AbTAMFJY>;
	Mon, 13 Jan 2003 00:09:24 -0500
Date: Mon, 13 Jan 2003 05:18:09 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Subject: Linux VM Documentation - Draft 2
In-Reply-To: <Pine.LNX.4.44.0301120210580.32623-100000@skynet>
Message-ID: <Pine.LNX.4.44.0301130426360.9912-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here goes draft 2. It is mainly spelling, grammar (spelled it right this
time) and formatting corrections largely thanks to Brian O'Connor and
David Woodhouse among others who went through it with a fine tooth comb
and sent me corrections.

The main technical error was pointed out by Ingo Oeser where I didn't go
through how data is copied from userspace properly. I've written a small
paragraph for the moment but have added a section on Copying To/From
Userspace to the TODO list which currently looks something like

o Swap area management
o High memory management
o Memory locking
o Copying To/From Userspace
o Arch independent initialisation (not covering arch dependent)
o Locking

It'll be a few weeks at the very least before I get them done though so
don't hold your breath just yet (Documentation is remarkably slow work).
If anyone sees other parts missing, has suggestions or sees more mistakes,
forward them on as any feedback is welcome.

The updated docs are at the same place, the links are

PDF:  http://www.csn.ul.ie/~mel/projects/vm/guide/pdf/understand.pdf
      http://www.csn.ul.ie/~mel/projects/vm/guide/pdf/code.pdf
HTML: http://www.csn.ul.ie/~mel/projects/vm/guide/html/understand/
      http://www.csn.ul.ie/~mel/projects/vm/guide/html/code/
Text: http://www.csn.ul.ie/~mel/projects/vm/guide/text/understand.txt
      http://www.csn.ul.ie/~mel/projects/vm/guide/text/code.txt

Enjoy....

--
Mel Gorman
University of Limerick




