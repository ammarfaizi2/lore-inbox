Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135944AbREGAvJ>; Sun, 6 May 2001 20:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135946AbREGAu7>; Sun, 6 May 2001 20:50:59 -0400
Received: from a1a90191.sympatico.bconnected.net ([209.53.18.14]:2688 "EHLO
	a1a90191.sympatico.bconnected.net") by vger.kernel.org with ESMTP
	id <S135944AbREGAuw>; Sun, 6 May 2001 20:50:52 -0400
Date: Sun, 6 May 2001 17:50:50 -0700
From: Shane Wegner <shane@cm.nu>
To: linux-kernel@vger.kernel.org
Subject: 2.2.20pre1: Problems with SMP
Message-ID: <20010506175050.A1968@cm.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
Organization: Continuum Systems, Vancouver, Canada
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just booted up 2.2.20pre1 and am getting some funny
results.  The system boots but is very slow.  Every few
seconds I get:
Stuck on TLB IPI wait (CPU#0)

Booting vanilla 2.2.19 works fine.  The machine is an
Intel Pentium III 850MHZ on an Abit VP6 board.  If any
further information is needed, let me know.

Regards,
Shane

-- 
Shane Wegner: shane@cm.nu
              http://www.cm.nu/~shane/
PGP:          1024D/FFE3035D
              A0ED DAC4 77EC D674 5487
              5B5C 4F89 9A4E FFE3 035D
