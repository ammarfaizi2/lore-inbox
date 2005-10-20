Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbVJTRiy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbVJTRiy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 13:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbVJTRiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 13:38:54 -0400
Received: from free.mekensleep.com ([81.57.75.249]:38785 "EHLO
	allin.dachary.org") by vger.kernel.org with ESMTP id S932504AbVJTRiy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 13:38:54 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17239.47055.862579.653443@allin.dachary.org>
Date: Thu, 20 Oct 2005 17:29:19 +0200
From: Loic Dachary <loic@gnu.org>
To: Pierre Michon <pierre.michon@gmail.com>
Cc: linux-kernel@vger.kernel.org, legal@lists.gpl-violations.org
Subject: Re: freebox possible GPL violation
In-Reply-To: Pierre Michon's message of 19 October 2005 19:58:22 +0200
References: <20051005084738.GA29944@linux.ensimag.fr>
	<17232.52887.293668.390641@allin.dachary.org>
	<908666c60510191058h6e87b9c5y@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Reply-To: loic@gnu.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pierre Michon writes:
 > PS : Does we need the binary image in order to ask for the source code ?
 > In this case, with Embedded devices that hide the firmware it will be
 > very difficult to make GPL apply...

        It is not mandatory, it's just easier in this specific case.
If we knew for sure what the firmware contains, the box would be
enough.  But if someone is able to figure out exactly what the
firmware contains she/he will also be able to extract a tarball in
which case the box itself becomes useless to ask for the corresponding
sources ;-)

        Cheers,

-- 
Loic Dachary, 12 bd Magenta, 75010 Paris. Tel: 33 8 71 18 43 38
http://www.fsffrance.org/   http://www.dachary.org/loic/gpg.txt
