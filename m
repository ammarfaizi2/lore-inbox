Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261525AbSJDIVI>; Fri, 4 Oct 2002 04:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261527AbSJDIVI>; Fri, 4 Oct 2002 04:21:08 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:46088 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S261525AbSJDIVI>; Fri, 4 Oct 2002 04:21:08 -0400
Message-ID: <3D9D50D4.A515B4EB@aitel.hist.no>
Date: Fri, 04 Oct 2002 10:27:00 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.40mm1 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Dave Jones <davej@codemonkey.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.40: menuconfig: no choice of keyboards
References: <20021002113053.GA482@arwen.brautaset.org> <200210021431.25941.sandersn@btinternet.com> <20021002154239.GB1988@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> Quite a few people seem to stumble over the new input layer options.
> It's non-obvious to quite a few people that serial i/o is anything to
> do with their keyboard. Likewise i8042 doesn't ring 'keyboard' noises
> in most peoples heads.
> 
> IMO, the input layer options need simplification, or at least
> a sensible set of defaults.

Well, the keyboard isn't magically attached.  It _is_ a kind
of serial device.  Making it default on, and calling the
thing  "i8042 (pc keyb/mouse)" ought to be enough.

Helge Hafting
