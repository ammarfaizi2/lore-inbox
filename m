Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312828AbSCZXQU>; Tue, 26 Mar 2002 18:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312826AbSCZXQJ>; Tue, 26 Mar 2002 18:16:09 -0500
Received: from [63.220.67.71] ([63.220.67.71]:60033 "EHLO
	frog.soft.sdesigns.com") by vger.kernel.org with ESMTP
	id <S312825AbSCZXP4>; Tue, 26 Mar 2002 18:15:56 -0500
To: linux-kernel@vger.kernel.org
Subject: SMP motherboards (760 MPX chipset) and SMP howto
From: Emmanuel Michon <emmanuel_michon@realmagic.fr>
Date: 27 Mar 2002 00:11:10 +0100
Message-ID: <7wsn6mx6up.fsf@frog.soft.sdesigns.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm sorry to write here for a problem only about SMP: there used to be
a linux-smp mailing list but it seems it's not active anymore.

It seems AMD Athlon SMP spec is compatible with Intel's one; can
someone report that the A7M266-D motherboard with the 760 MPX chipset
is running fine linux SMP?

People reported that this combo works properly even with two Athlon XP's
instead of MP's: how do you force this motherboard into SMP mode?

I'm also looking for a ``howto'' explaining where non-SMP-aware module
code will most probably crash a SMP box, it seems there is no such
thing.

SMP gurus must have a discussion room more specific than linux-kernel
mailing list at some hidden place!

Sincerely yours,

-- 
Emmanuel Michon
Chef de projet
REALmagic France SAS
Mobile: 0614372733 GPGkeyID: D2997E42  
