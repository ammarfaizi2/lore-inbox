Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264936AbUFAHYm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264936AbUFAHYm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 03:24:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264916AbUFAHYi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 03:24:38 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:33679 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S264919AbUFAHYS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 03:24:18 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i8042_shutdown bug: Linux 2.6.7-rc2
References: <xb7zn7q81fe.fsf@savona.informatik.uni-freiburg.de>
	<20040530140446.GB2053@ucw.cz>
	<xb7r7t280rd.fsf@savona.informatik.uni-freiburg.de>
	<20040530142632.GA3150@ucw.cz>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 01 Jun 2004 09:24:17 +0200
In-Reply-To: <20040530142632.GA3150@ucw.cz>
Message-ID: <xb7brk391we.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Vojtech" == Vojtech Pavlik <vojtech@suse.cz> writes:

    >> >> This bug is still in 2.6.7-rc2:
    >> >> 
    >> >> See: http://lkml.org/lkml/2004/5/10/63
    >> 
    Vojtech> Yes, my tree wasn't yet merged into mainline, as I'm
    Vojtech> fixing locking in atkbd and psmouse now.

    >>  I see.  Will it be in 2.6.7?

    Vojtech> Unlikely. 2.6.7 is already in its rc stage, so 2.6.8 will
    Vojtech> likely be the target.

Why not?   This is a  bug fix --  a bug that  hangs the kernel,  not a
brand new, cool, untested feature.

What's the point of the RC status, then?



-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

