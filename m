Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132799AbRDQSMp>; Tue, 17 Apr 2001 14:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132800AbRDQSMf>; Tue, 17 Apr 2001 14:12:35 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:11793 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S132799AbRDQSM0>;
	Tue, 17 Apr 2001 14:12:26 -0400
Date: Tue, 17 Apr 2001 14:13:35 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: CML2 1.1.4 is available
Message-ID: <20010417141335.A32711@thyrsus.com>
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

Release 1.1.4: Tue Apr 17 14:02:17 EDT 2001
	* Tom Rini's patches for the ARM port tree.
	* Correct handling of booleans when trits are disabled.
	* `nohelp' tie symbol introduced.
	* Code audited with PyChecker.

The fact that most of the arguments about recent releases have to do with
color selection in the UI tells me that the UI is just about good enough.
The sluggishness complaints seem to have subsided as well.

So let's try to shift our attention to auditing and fixing the rules files,
shall we?
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

He who joyfully marches to music in rank and file has already earned my
contempt.  He has been given a large brain by mistake, since for him the
spinal cord would fully suffice.
	-- Albert Einstein
