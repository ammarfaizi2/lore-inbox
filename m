Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133058AbRDLHJj>; Thu, 12 Apr 2001 03:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133059AbRDLHJa>; Thu, 12 Apr 2001 03:09:30 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:6917 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S133058AbRDLHJK>;
	Thu, 12 Apr 2001 03:09:10 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200104120709.f3C798Y426000@saturn.cs.uml.edu>
Subject: Re: CML2 1.0.0 release announcement
To: esr@snark.thyrsus.com (Eric S. Raymond)
Date: Thu, 12 Apr 2001 03:09:08 -0400 (EDT)
Cc: linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
In-Reply-To: <200104101047.f3AAl0h07395@snark.thyrsus.com> from "Eric S. Raymond" at Apr 10, 2001 06:47:00 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * All three interfaces do progressive disclosure -- the user only sees
>   questions he/she needs to answer (no more hundreds of greyed-out menu
>   entries for irrelevant drivers!).

Well, that sucks. The greyed-out menu entries were the only good
thing about xconfig. Such entries provide a clue that you need
to enable something else to get the feature you desire. Otherwise
you might figure that the feature is missing, or that you have
overlooked it.
