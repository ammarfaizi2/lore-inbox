Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289053AbSAGAWA>; Sun, 6 Jan 2002 19:22:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289054AbSAGAVv>; Sun, 6 Jan 2002 19:21:51 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:37535
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289053AbSAGAVp>; Sun, 6 Jan 2002 19:21:45 -0500
Date: Sun, 6 Jan 2002 19:07:43 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: CML@-2.0.3
Message-ID: <20020106190743.A27598@thyrsus.com>
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


Release 2.0.3: Sun Jan  6 19:04:28 EST 2002
	* Massive autoprobe rules update by Giacomo.
	* Vital symbols (those that are critical, like disk drivers for 
	  potential root devices) are now forced to Y when the autoconfigurator
	  finds their hardware.

The autoconfigurator is much snmarter now, but running a manual
configure afterwards is recommended.

This release also fixes a bug in field entry of hexadecimal symbol values.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Since there is no such entity as 'the public,' since the public is merely a
number of individuals, the idea that 'the public interest' supersedes private
interests and rights can have but one meaning: that the interests and rights of
some individuals take precedence over the interests and rights of others."
	-- Ayn Rand
