Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271260AbRIDNH2>; Tue, 4 Sep 2001 09:07:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271289AbRIDNHT>; Tue, 4 Sep 2001 09:07:19 -0400
Received: from victor.ndsuk.com ([194.202.59.31]:26131 "EHLO victor.ndsuk.com")
	by vger.kernel.org with ESMTP id <S271260AbRIDNHG>;
	Tue, 4 Sep 2001 09:07:06 -0400
Message-ID: <F128989C2E99D4119C110002A507409801555FD8@topper.hrow.ndsuk.com>
From: "Elgar, Jeremy" <JElgar@ndsuk.com>
To: linux-kernel@vger.kernel.org
Subject: Applying multiple patches 
Date: Tue, 4 Sep 2001 14:07:56 +0100 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
Sorry if this is covered somewhere but I had a look last night (and asked
various people) but came up blank.

Is there a way to apply multiple patches to a source tree (if the patches
were produced from the same base tree)

The problem I have is thus,  I want to apply patch-2.4.9-ac6 (I guess might
as well do ac7 now) and the xfs patch
but both are from a vanilla 2-4-9.

Is there a standard way of doing this or is a `by hand solution`

(I managed to apply the ac first then the xfs (ignoring a couple of files
that are older in ac) but it was the config file that was messed up)

Its probably quite simple but I couldn't figure it

Cheers

Jeremy




 
===============================================================
Information contained in this email message is intended only for
use of the individual or entity named above. If the reader of this
message is not the intended recipient, or the employee or agent
responsible to deliver it to the intended recipient, you are hereby
notified that any dissemination, distribution or copying of this
communication is strictly prohibited. If you have received this
communication in error, please immediately notify us by email
to postmaster@ndsuk.com and destroy the original message. 


