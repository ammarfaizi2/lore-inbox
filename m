Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbWHPAFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbWHPAFu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 20:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750707AbWHPAFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 20:05:50 -0400
Received: from moutng.kundenserver.de ([212.227.126.188]:53999 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750703AbWHPAFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 20:05:49 -0400
From: Bodo Eggert <7eggert@elstempel.de>
Subject: Re: bonding: cannot remove certain named devices
To: Stephen Hemminger <shemminger@osdl.org>,
       Mitch Williams <mitch.a.williams@intel.com>,
       Bill Nottingham <notting@redhat.com>,
       ?missing.closing.'"' in token?"Williams",
	Mitch A <mitch.a.williams@intel.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org"@vax.1wt.eu
Illegal-Object: Syntax error in To: address found on vger.kernel.org:
	To:	?missing closing '"' in token?"Williams", Mitch A <mitch.a.williams@intel.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org"
			^				       ^-missing closing '"' in token
		 \-extraneous tokens in address
Illegal-Object: Syntax error in To: address found on vger.kernel.org:
	To:	?missing closing '"' in token?"Williams", Mitch A <mitch.a.williams@intel.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org"
			^				       ^-missing closing '"' in token
		 \-extraneous tokens in address
Reply-To: 7eggert@gmx.de
Date: Wed, 16 Aug 2006 02:02:03 +0200
References: <6Kd5j-3Y7-3@gated-at.bofh.it> <6KdRL-5xP-7@gated-at.bofh.it> <6Ke1p-5N8-7@gated-at.bofh.it> <6KekO-6u0-25@gated-at.bofh.it> <6KeXv-7qe-17@gated-at.bofh.it> <6KfTz-OX-11@gated-at.bofh.it> <6KfTA-OX-15@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
X-Troll: Tanz
Message-Id: <E1GD8rX-0001cA-CV@be1.lrz>
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@elstempel.de
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:9b3b2cc444a07783f194c895a09f1de9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Hemminger <shemminger@osdl.org> wrote:

> IMHO idiots who put space's in filenames should be ignored. As long as the
> bonding code doesn't throw a fatal error, it has every right to return
> "No such device" to the fool.

Maybe you should limit device names to eight uppercase characters and up to
three characters extension, too. NOT! There is no reason to artificially
impose limitations on device names, so don't do that.
-- 
Ich danke GMX dafür, die Verwendung meiner Adressen mittels per SPF
verbreiteten Lügen zu sabotieren.

http://david.woodhou.se/why-not-spf.html
