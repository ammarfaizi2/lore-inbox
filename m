Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264432AbUDSNiz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 09:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264451AbUDSNhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 09:37:42 -0400
Received: from adsl-76-231.38-151.net24.it ([151.38.231.76]:44562 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S264449AbUDSNfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 09:35:11 -0400
Date: Mon, 19 Apr 2004 15:35:08 +0200
From: Daniele Venzano <webvenza@libero.it>
To: "Michal Semler (volny.cz)" <cijoml@volny.cz>
Cc: linux-kernel@vger.kernel.org, irda-users@lists.sourceforge.net
Subject: Re: 2.4.26 IRDA BUG - blocker
Message-ID: <20040419133507.GB10382@gateway.milesteg.arr>
Mail-Followup-To: "Michal Semler (volny.cz)" <cijoml@volny.cz>,
	linux-kernel@vger.kernel.org, irda-users@lists.sourceforge.net
References: <200404190152.16594.cijoml@volny.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200404190152.16594.cijoml@volny.cz>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.25-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 19, 2004 at 01:52:16AM +0200, Michal Semler (volny.cz) wrote:
> When I try connect with 2.4.26 kernel to T68i
> I getts this message and then port freezes - no devices discovered and no 
> communication, sometimes freezes whole laptop:

I'm seeing this same behaviour with a Nokia 6610, same modules, same
messages, but kernel 2.6.5.
I also noted that with irdaping I loose one ping every 2, so that
sequence numbers follow the following pattern:
1
2
4
5
7
8
...

-- 
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org

