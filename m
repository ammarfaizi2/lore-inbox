Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S129463AbQJEMxB>; Thu, 5 Oct 2000 08:53:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S129149AbQJEMws>; Thu, 5 Oct 2000 08:52:48 -0400
Received: from d06lmsgate-2.uk.ibm.com ([195.212.29.2]:30125 "EHLO d06lmsgate-2.uk.ibm.com") by vger.kernel.org with ESMTP id <S129114AbQJEMwl>; Thu, 5 Oct 2000 08:52:41 -0400
From: richardj_moore@uk.ibm.com
X-Lotus-FromDomain: IBMGB
To: Daniel Phillips <phillips@innominate.de>
cc: linux-kernel@vger.kernel.org
Message-ID: <8025696F.003E1C8B.00@d06mta06.portsmouth.uk.ibm.com>
Date: Thu, 5 Oct 2000 12:18:36 +0100
Subject: Re: Phase tree algorithm defined
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Daniel,

This is very valuable - thanks for makeing the effort.

You could enhance you document greatly if you provided a few diagrams to
illustrate the structure, especially  the example file system.  I'd suggest
converting the document to  HTML or XML.

Also, I'd like to understand how the Phase Tree differs from other tree
schemes used by files systems, for example the Modified Patricia Tree used
by HPFS and NTFS. It wasn't quite clear to me how the advantages of
consistency are obtained, but diagrams might help.


Richard Moore -  RAS Project Lead - Linux Technology Centre (PISC).

http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


Daniel Phillips <news-innominate.list.linux.kernel@innominate.de> on
05/10/2000 05:53:30

Please respond to Daniel Phillips <phillips@innominate.de>

To:   linux-kernel@vger.kernel.org
cc:    (bcc: Richard J Moore/UK/IBM)
Subject:  Phase tree algorithm defined




I have finally produced something resembling a formal definition of the
phase tree algorithm.  As you will see, this algorithm is somewhat
subtle, and not easy to express in clear simple terms.  But I think that
I have in fact expressed it clearly in simply.  If I have not, I wish
very much to be told so, and why.

You can get a copy here:

  http://innominate.org/~phillips/tux2/phase.tree.algorithm.txt

Please, if you are especially anal and nasty and have little regard for
anyone's feelings, read this and complain about every little thing that
is wrong with it, and I will greatly appreciate that.  I will also
appreciate comments of the form 'you left out this or that', or 'this
part sounds like so much bafflegab' and so on.

Enjoy.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
