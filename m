Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287388AbSAPUMH>; Wed, 16 Jan 2002 15:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287368AbSAPUL5>; Wed, 16 Jan 2002 15:11:57 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:7553
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S287388AbSAPULx>; Wed, 16 Jan 2002 15:11:53 -0500
Date: Wed, 16 Jan 2002 14:56:05 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: CML2-2.1.4 is available
Message-ID: <20020116145605.A10792@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version is always available at <http://www.tuxedo.org/~esr/cml2/>.

Release 2.1.4: Wed Jan 16 14:42:57 EST 2002
	* Resync with 2.4.18-pre4 and 2.5.3-pre1.
	* Fixed a nasty little bug in property computation.
	* Fixed another nasty little bug in display of constraint violations.

I fat-fingered some display code in 2.1.3 while trying to do a better job of
passing rulesfile line number information back in error popups.  This patch
fixes that problem.

The autoconfigurator is progressing nicely.  It now generates a
correct configuration in "Look, ma! No hands." mode on three different
Intel boxes -- my all-PCI SCSI custom monster machine, an IDE-based IBM
Thinkpad laptop, and a hybrid PCI/ISA VA box from late '97.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The conclusion is thus inescapable that the history, concept, and 
wording of the second amendment to the Constitution of the United 
States, as well as its interpretation by every major commentator and 
court in the first half-century after its ratification, indicates 
that what is protected is an individual right of a private citizen 
to own and carry firearms in a peaceful manner.
         -- Report of the Subcommittee On The Constitution of the Committee On 
            The Judiciary, United States Senate, 97th Congress, second session 
            (February, 1982), SuDoc# Y4.J 89/2: Ar 5/5
