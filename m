Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289904AbSAKJVT>; Fri, 11 Jan 2002 04:21:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289905AbSAKJVJ>; Fri, 11 Jan 2002 04:21:09 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:10915
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289904AbSAKJU6>; Fri, 11 Jan 2002 04:20:58 -0500
Date: Fri, 11 Jan 2002 04:05:33 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net
Subject: CML2-2.1.2 is available
Message-ID: <20020111040533.A10940@thyrsus.com>
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

The latest version is always available at <http://www.tuxedo.org/~esr/cml2/>.

Release 2.1.2: Fri Jan 11 03:50:36 EST 2002
	* Resync with 2.5.2-pre11.
	* Properties introduced.  Symbols can now have associated class flags.
	  to be used by configurator programs.
	* Frozen symbols are no longer visible.

Checkpoint release.  The compiler has just undergone major surgery, so this
one may be a bit buggier than typical recently (though it passed all my
standard tests).  I'm in the throes of introducing property-annotation 
macinery for use by the autoconfigurator.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The United States is in no way founded upon the Christian religion
	-- George Washington & John Adams, in a diplomatic message to Malta.
