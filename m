Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131042AbRAGXUu>; Sun, 7 Jan 2001 18:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135332AbRAGXUj>; Sun, 7 Jan 2001 18:20:39 -0500
Received: from snark.tuxedo.org ([207.106.50.26]:4107 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S131042AbRAGXU0>;
	Sun, 7 Jan 2001 18:20:26 -0500
Date: Sun, 7 Jan 2001 18:18:32 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: CML2 0.9.1 is available
Message-ID: <20010107181832.A5612@thyrsus.com>
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

The latest version is always available at http://www.tuxedo.org/~esr/cml2/

Release 0.9.1: Sun Jan  7 18:05:36 EST 2001
	* Synchronized with 2.4.0 final.
	* Fixed bugs in handling of -W and -D flags.
	* "source" pathnames are now evaluated relative relative to the 
	  directory of the including file, so it's now possible to compile
	  in a directory other than that of the rules file.

Special thanks to Giacomo Catenazzi, whose persistence about
reporting front-end bugs finally pushed me in the right direction to
find some obscure problems I had never been able to reproduce before.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

To stay young requires the unceasing cultivation of the ability to
unlearn old falsehoods.
	-- Lazarus Long 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
