Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132733AbRDNDQq>; Fri, 13 Apr 2001 23:16:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132734AbRDNDQh>; Fri, 13 Apr 2001 23:16:37 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:1029 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132733AbRDNDQ0>;
	Fri, 13 Apr 2001 23:16:26 -0400
Date: Fri, 13 Apr 2001 23:17:57 -0400
Message-Id: <200104140317.f3E3Hv805992@snark.thyrsus.com>
From: "Eric S. Raymond" <esr@snark.thyrsus.com>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: CML 1.1.0, aka "I feel the need...the need for speed."
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The latest version is always available at http://www.tuxedo.org/~esr/cml2/

Release 1.1.0: Fri Apr 13 23:10:56 EDT 2001
	* Better-controlled recursivity in the theorem prover; reading in
	  defconfigs is much faster now.
	* Revised config/xconfig/menuconfig/oldconfigs productions, these
	  should be a better match for the expected behavior now.
	* Ternary-select (a ? b : c) added to the language.

Configurator startup is now so much faster it's almost ridiculous.  Wheee!

I added ternary-select to handle some weird cases in the CRIS port
tree for 2.4.4-pre1.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Question with boldness even the existence of a God; because, if there
be one, he must more approve the homage of reason, than that of
blindfolded fear.... Do not be frightened from this inquiry from any
fear of its consequences. If it ends in the belief that there is no
God, you will find incitements to virtue in the comfort and
pleasantness you feel in its exercise...
	-- Thomas Jefferson, in a 1787 letter to his nephew
