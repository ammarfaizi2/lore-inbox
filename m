Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270178AbRHSGil>; Sun, 19 Aug 2001 02:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270180AbRHSGib>; Sun, 19 Aug 2001 02:38:31 -0400
Received: from snark.tuxedo.org ([207.106.50.26]:60422 "EHLO snark.thyrsus.com")
	by vger.kernel.org with ESMTP id <S270178AbRHSGiQ>;
	Sun, 19 Aug 2001 02:38:16 -0400
Date: Sun, 19 Aug 2001 02:42:33 -0400
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: gars@lanm-pc.com
Subject: Swap size for a machine with 2GB of memory
Message-ID: <20010819024233.A26916@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, gars@lanm-pc.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The Red Hat installation manual claims that the size of the swap partition
should be twice the size of physical memory, but no more than 128MB.

The screaming hotrod machine Gary Sandine and I built around the Tyan S2464
has 2GB of physical memory.  Should I believe the above formula?  If not,
is there a more correct one for calculating needed swap on machines with
very large memory?

(No further hangs, BTW.)
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

.. a government and its agents are under no general duty to 
provide public services, such as police protection, to any 
particular individual citizen...
        -- Warren v. District of Columbia, 444 A.2d 1 (D.C. App.181)
