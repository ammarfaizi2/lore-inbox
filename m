Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267429AbTB1CbJ>; Thu, 27 Feb 2003 21:31:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267431AbTB1CbJ>; Thu, 27 Feb 2003 21:31:09 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:58507 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id <S267429AbTB1CbH>;
	Thu, 27 Feb 2003 21:31:07 -0500
Date: Fri, 28 Feb 2003 02:41:14 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: linux-mm@kvack.org, <linux-kernel@vger.kernel.org>
Subject: VM Documentation Release Day
Message-ID: <Pine.LNX.4.44.0302280156450.14671-100000@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a beginning of the end release of the VM documentation against
2.4.20 as it contains information on pretty much all of the VM. A lot of
the older chapters have been cleaned up in terms of language, font usage
and presentation and a few new chapters are new. Please excuse if the
swapping chapter is a bit rough, I wanted to get this done by the weekend
so I can head away offline and not have to worry about it.

The whole documentation is broken up into two major sets of documents.
understand.foo is the main document describing how the VM works and
code.foo is a fairly detailed code commentary to guide through the sticky
parts. It can be found in PDF(preferred format), HTML or plain text at

Understand the VM
PDF:  http://www.csn.ul.ie/~mel/projects/vm/guide/pdf/understand.pdf
HTML: http://www.csn.ul.ie/~mel/projects/vm/guide/html/understand/
Text: http://www.csn.ul.ie/~mel/projects/vm/guide/text/understand.txt

Code Commentary
PDF:  http://www.csn.ul.ie/~mel/projects/vm/guide/pdf/code.pdf
HTML: http://www.csn.ul.ie/~mel/projects/vm/guide/html/code
Text: http://www.csn.ul.ie/~mel/projects/vm/guide/text/code.txt

This is a huge milestone for me (I'm actually quite proud of myself!) It
has come a *long* way since I wrote
http://marc.theaimsgroup.com/?l=linux-mm&m=99907898511387&w=2 which was
around when I first untarred the source with a view to seriously reading
it :-) (The larger project never really got as far as I thought, I
drastically underestimated how long this would take and it was large
enough project as it was)

At this stage, I'm nearing the end of the documentation work for the
2.4.20 VM. If I write anything for 2.5, it'll be in the shape of addendums
where I describe the differences rather than going through all this again.
All that I have left really is to polish it (especially the later chapters
like swap management) and fill in some gaps (particularly filling out the
page cache management a bit more). I'm now hoping people will read through
it, tell me where and if I've made technical errors, suggestions for
improvements or tell me where I've missed on topics that really should
have been covered.

When the final polish is done, the whole document, LaTeX source and all
will be uploaded to somewhere more accessible than my webpage. At this
stage, presuming people do not start pointing out horrible mistakes I've
made, I'm hoping that the final version is not too far away. Suggestions,
comments and feedback are welcome.

 --
Mel Gorman
MSc Student, University of Limerick
http://www.csn.ul.ie/~mel



