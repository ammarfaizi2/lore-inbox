Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289659AbSAOUJK>; Tue, 15 Jan 2002 15:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289639AbSAOUJA>; Tue, 15 Jan 2002 15:09:00 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:20865
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S289644AbSAOUI4>; Tue, 15 Jan 2002 15:08:56 -0500
Date: Tue, 15 Jan 2002 14:53:24 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: CML2-2.1.3 is available
Message-ID: <20020115145324.A5772@thyrsus.com>
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

The latest version is always available at <http://www.tuxedo.org/~esr/cml2/>.

Release 2.1.3: Tue Jan 15 14:41:45 EST 2002
	* Resync with 2.4.18-pre3 and 2.5.2.
	* It is now possible to declare explicit saveability predicates.
	* The `vitality' flag is gone from the language.  Instead, the 
	  autoprober detects the type of your root filesystem and forces
	  its symbol to Y.

The interactive configurators remain stable; no bugs of any kind have been 
reported since 6 Jan.  I'm waiting on an update of the probe tables from
Giacomo Catenazzi before releasing 2.2.0.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

Under democracy one party always devotes its chief energies
to trying to prove that the other party is unfit to rule--and
both commonly succeed, and are right... The United States
has never developed an aristocracy really disinterested or an
intelligentsia really intelligent. Its history is simply a record
of vacillations between two gangs of frauds. 
	--- H. L. Mencken
