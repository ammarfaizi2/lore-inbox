Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287944AbSABU2q>; Wed, 2 Jan 2002 15:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287949AbSABU2f>; Wed, 2 Jan 2002 15:28:35 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:24707
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S287944AbSABU2X>; Wed, 2 Jan 2002 15:28:23 -0500
Date: Wed, 2 Jan 2002 15:15:39 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: ISA slot detection on PCI systems?
Message-ID: <20020102151539.A14925@thyrsus.com>
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

Is there any way to safely probe a PCI motherboard to determine whether
or not it has ISA cards present, or ISA card slots?

Note: the question is *not* about a probe for whether the board has an ISA
bridge, but a probe for the presence of actual ISA cards (or slots).

(Yes, I'm working on a smart autoconfigurator.  It's a development of
Giacomo Catenazzi's code, but able to use the CML2 deduction engine.)
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

[W]hat country can preserve its liberties, if its rulers are not
warned from time to time that [the] people preserve the spirit of
resistance?  Let them take arms...The tree of liberty must be
refreshed from time to time, with the blood of patriots and tyrants.
	-- Thomas Jefferson, letter to Col. William S. Smith, 1787 
