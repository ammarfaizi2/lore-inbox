Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129846AbQLMSRc>; Wed, 13 Dec 2000 13:17:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129870AbQLMSRW>; Wed, 13 Dec 2000 13:17:22 -0500
Received: from snark.tuxedo.org ([207.106.50.26]:64267 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S130109AbQLMSRG>;
	Wed, 13 Dec 2000 13:17:06 -0500
Date: Wed, 13 Dec 2000 12:46:42 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: CML2-0.9.0 is now  available
Message-ID: <20001213124642.A24121@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version is always available at http://www.tuxedo.org/~esr/kbuild/

Release 0.9.0: Wed Dec 13 01:30:21 EST 2000
	* Now uses Python 2.0 (this cuts down the code size significantly).
	* Synchronized with 2.4.0-test12.

Using Python 2.0 rather than 1.5.2 lets me cut close to 600 lines out of the
CML2 system, a bit more than 10% of the 5334 lines of code in this version.

This code is ready to be used for production.

For those of you who may be new since the last release, CML2 is a
drop-in replacement for the existing make config/menuconfig/xconfig
machinery that has been endorsed by the current kbuild maintainers.
It is smaller, *much* cleaner, and includes powerful new features 
including automatic deduction of correct side-effects whenever you
change a configuration symbol.  Details at the project page given above.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

You know why there's a Second Amendment?  In case the government fails to
follow the first one.
         -- Rush Limbaugh, in a moment of unaccustomed profundity 17 Aug 1993
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
