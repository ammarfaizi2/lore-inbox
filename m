Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286108AbRLTFRK>; Thu, 20 Dec 2001 00:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286100AbRLTFQ7>; Thu, 20 Dec 2001 00:16:59 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:41601
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S286099AbRLTFQz>; Thu, 20 Dec 2001 00:16:55 -0500
Date: Thu, 20 Dec 2001 00:04:45 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: CML2 1.9.11 is available
Message-ID: <20011220000445.A8684@thyrsus.com>
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

Release 1.9.11: Wed Dec 19 23:57:21 EST 2001
	* Added a ruleset-debugging mode to cmlconfigure.py.
	* Add 'like' keyword so help entries can be re-used by reference.
	* Fix some scoping problems in kxref.py that confused pre-2.2 Pythons.

I haven't solved Richard Todd's bugs in the logic engine yet =-- fortunately
they don't show up in ordinary use.  I expect to nail these shortly.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Americans have the will to resist because you have weapons. 
If you don't have a gun, freedom of speech has no power.
         -- Yoshimi Ishikawa, Japanese author, in the LA Times 15 Oct 1992
