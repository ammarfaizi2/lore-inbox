Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135579AbRDSHCC>; Thu, 19 Apr 2001 03:02:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135580AbRDSHBw>; Thu, 19 Apr 2001 03:01:52 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:38665 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135579AbRDSHBk>;
	Thu, 19 Apr 2001 03:01:40 -0400
Date: Thu, 19 Apr 2001 03:02:37 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: After implementing logic to ignore changelogs...
Message-ID: <20010419030237.A30242@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	CML2 <linux-kernel@vger.kernel.org>,
	kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After implementing logic to strip out comments in .c and .h files, and
to ignore changelog files, the number of broken symbols in 2.4.4pre4
drops from 731 to 699.  Most of the cruft is real cruft.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

In recent years it has been suggested that the Second Amendment
protects the "collective" right of states to maintain militias, while
it does not protect the right of "the people" to keep and bear arms.
If anyone entertained this notion in the period during which the
Constitution and the Bill of Rights were debated and ratified, it
remains one of the most closely guarded secrets of the eighteenth
century, for no known writing surviving from the period between 1787
and 1791 states such a thesis.
        -- Stephen P. Halbrook, "That Every Man Be Armed", 1984
