Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135530AbRDSDBk>; Wed, 18 Apr 2001 23:01:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135529AbRDSDBb>; Wed, 18 Apr 2001 23:01:31 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:11529 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S135528AbRDSDBT>;
	Wed, 18 Apr 2001 23:01:19 -0400
Date: Wed, 18 Apr 2001 23:02:17 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: CML2 1.2.0 is available
Message-ID: <20010418230217.A28522@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version is always available at http://www.tuxedo.org/~esr/cml2/

Release 1.2.0: Wed Apr 18 22:09:57 EDT 2001
	* Synchronized with 2.4.4-pre4.
	* First release of kxref.py.

That second little item is more important than it sounds -- kxref.py
is a cross-referencing tool that can unerringly detect orphaned config
symbols lurking in various obscure crevices of the source tree.

There are over 700 of these orphans in the 2.4.4pre4 tree!  That's a lot
of cruft and bulk and a substantial drag on the readability of the code.

I'll fix this, if the dieties Linus and Alan do not hinder.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>


Yes, the president should resign.  He has lied to the American people, time
and time again, and betrayed their trust.  Since he has admitted guilt,
there is no reason to put the American people through an impeachment.  He
will serve absolutely no purpose in finishing out his term, the only
possible solution is for the president to save some dignity and resign.
	-- 12th Congressional District hopeful Bill Clinton, during Watergate
