Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311622AbSCTGrv>; Wed, 20 Mar 2002 01:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311623AbSCTGrb>; Wed, 20 Mar 2002 01:47:31 -0500
Received: from smtp.tele.fi ([192.89.123.25]:60618 "EHLO smtp.tele.fi")
	by vger.kernel.org with ESMTP id <S311622AbSCTGr1>;
	Wed, 20 Mar 2002 01:47:27 -0500
Message-ID: <3C983053.BFEA351B@syscon-automation.fi>
Date: Wed, 20 Mar 2002 08:46:43 +0200
From: Ismo Salonen <ismo.salonen@syscon-automation.fi>
Organization: Syscon Automation OY
X-Mailer: Mozilla 4.77 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Specialix SI patches available - SI V1.x support
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello 

Yesterday I patched the Specialix SX driver (sx.c,sx.h and sxboard.h)
and now I can use my old (1988) SI host adapter (with two terminal
adapters,
totally 16 ports) :-) . 

Is there anybody who has similar harware and would have some spare time 
to test it more thoroughly ? 

Or should I submit the changes directly to the maintainer of that code ?

I also have ported the old DigiBoard Com/Xi driver by Simon Poole to
current 
kernel, however there are some problems with it, handling of termio
settings
are not is synch with upper level, anybody intrested in inspecting that
code.
( I could reach anybody named in the source by email, all addresses
bounce)

ismo
