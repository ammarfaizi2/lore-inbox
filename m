Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291533AbSBAETz>; Thu, 31 Jan 2002 23:19:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291534AbSBAETo>; Thu, 31 Jan 2002 23:19:44 -0500
Received: from mailout6-0.nyroc.rr.com ([24.92.226.125]:6868 "EHLO
	mailout6.nyroc.rr.com") by vger.kernel.org with ESMTP
	id <S291533AbSBAET3>; Thu, 31 Jan 2002 23:19:29 -0500
Message-Id: <4.3.2.7.2.20020131223241.03abfff0@mail.rational-liberty.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Thu, 31 Jan 2002 23:19:20 -0500
To: linux-kernel@vger.kernel.org
From: Meme Engineer <engineer@meme-engineer.com>
Subject: Documentation Lying on Floor?
Cc: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond muttered on Tuesday, 29 Jan 2002:
 >
 > Since the "33 times in a row" seems to refer to my bad
 > experience with the Configure.help patches, I think I
 > need to correct a misconception.
 >
 > The patches in question were *documentation*.  No
 > concept issue, no timing issue, no testing issue (I don't
 > know what a "cleanliness" issue would be in this context).
 > I know that Michael Elizabeth Chastain, the listed CML1
 > maintainer, has had similar frustrating experiences trying
 > to get documentation patches folded in.
 >
 > We're not talking about obscure internals changes that could
 > break the kernel, we're talking zero-risk patches submitted
 > by official maintainers.  This is not a situation that ought to
 > require a lot of judgment or attention on Linus's part.

 > The fact that Linus *does* have to pass on all such patches,
 > and is dropping a lot of them them on the floor, is the clearest
 > possible example of the weaknesses in the present system.

   Why not split off the documentation from the kernel? Send along with
the kernel package an XML documentation database (plus a simple text
version for easy human reading and for automated parsing by non-XML
scripts). The separately downloaded (or included) DBMS program calls
only needed documentation upon request (the TARred and GZIPped
package content is automatically opened into appropriate locations
after the download), plus suggested further reading based upon the
expressed sophistication of the downloader (templates are available
presumably at a variety of locations, with various suggestion lists for
kernel recompilation, or Samba setup, or encrypted XFS setup, or any
other expressed or implied interest). (Consider XLink and XPath).

   http://www.oasis-open.org/cover/xll.html

   The documentation templates would have signoffs by various people,
and those who wished to do so could easily chose to download only the
documentation package suggested by the simple template that only has
documentation approved by Linus. An adventurous individual might
chose documentation approved by Linus and by Alan Cox, or only by
Alan Cox, or by any mix of known commentators, (no suggestion here
is meant of relative merits of judgement of any commentator).

   It seems foolish to deny by default to people such possibly more useful
documentation on an extreme technicality such as not being yet looked
over by one single individual. Code works or it does not work, but good
documentation is vital and often sorely lacking for the hapless newcomer
who is massively confused by GNU/Linux (the concept of Linux and the
accompanying packages from the GNU project). Good documentation is
core programming for the mind of the newcomer or expert user, and it is
in the end for the user (me and thee) that is all this hard, time-consuming
work on a sophisticated, modern kernel.

   This would fit well on a site with a dynamically generated template
suggested upon answering questions about one's physical hardware,
if possible, or upon an attempt by a small downloaded program (even
a small Windows program, hee-hee, snicker) to determine the intended
hardware host for Linux and therefore the required or suggested drivers
and documentation.

   Cheers, Meme Engineer

