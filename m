Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280615AbRKYAaq>; Sat, 24 Nov 2001 19:30:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280586AbRKYAag>; Sat, 24 Nov 2001 19:30:36 -0500
Received: from cpu2747.adsl.bellglobal.com ([207.236.55.216]:43001 "EHLO
	golux.thyrsus.com") by vger.kernel.org with ESMTP
	id <S280585AbRKYAaa>; Sat, 24 Nov 2001 19:30:30 -0500
Date: Sat, 24 Nov 2001 19:26:39 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: CML 1.9.0 is available
Message-ID: <20011124192639.A5607@thyrsus.com>
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

Release 1.9.0: Sat Nov 24 18:50:22 EST 2001
	* Sync with 2.4.15/2.5.0 (except for SH port).
	* Correct a minor bug in validation of trit expressions.
	* Improved visibility computation: symbols with ancestors
	  frozen at n are no longer saved to config.out.

This version corresponds to the kernel and config state as of the 2.5.0 fork.

The bug list is empty.   The to-do list is empty.  This code is ready.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

The two pillars of `political correctness' are, 
  a) willful ignorance, and
  b) a steadfast refusal to face the truth
	-- George MacDonald Fraser
