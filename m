Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269075AbUHYBS3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269075AbUHYBS3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 21:18:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269085AbUHYBS3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 21:18:29 -0400
Received: from main.gmane.org ([80.91.224.249]:16271 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269075AbUHYBS1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 21:18:27 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: fraga@abusar.org ( =?ISO-8859-1?Q?D=E2niel?= Fraga)
Subject: Re: Linux 2.6.9-rc1
Date: Tue, 24 Aug 2004 22:01:28 -0300
Organization: http://www.turbonerd.hpg.ig.com.br
Message-ID: <805tv1-ec2.ln1@tux.abusar.org>
References: <Pine.LNX.4.58.0408240031560.17766@ppc970.osdl.org>
    <20040824184245.GE5414@waste.org>
    <Pine.LNX.4.58.0408241221390.17766@ppc970.osdl.org>
    <cggjvs$bv9$1@sea.gmane.org> <412BD946.1080908@linux-user.net>
Reply-To: fraga@abusar.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 200-207-206-233.dsl.telesp.net.br
X-Newsreader: knews 1.0c.0
X-Leafnode-Warning: administrator allowed illegal use of 8-bit data in header.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <412BD946.1080908@linux-user.net>,
	Daniel Andersen <anddan@linux-user.net> writes:

> As Linus initially said, there is the possibility of releasing a bug-fix 
> patch 2.6.8.2 *after* 2.6.9 has been released. This can make things very 

	Why does this could happen? Do you agree with me that when 2.6.9 is
released, all future versions should be based on 2.6.9? Or it's a BK
issue I don't know?

> confusing when patch-2.6.9 is against 2.6.8.1 and not 2.6.8.2 (or 
> 2.6.8). So if we use a rule of always patching against the first x.y.Z 
> release (and not the last x.y.z.W by the time the new x.y.Z is released) 
> we can assure consistence in the patch management.

	Ok, I understand the problem. But isn't it possible to avoid
releasing some 2.6.8.x version after 2.6.9? I mean, I'm not
understanding why this could happen.

	Ps: sorry if this question is silly, but I didn't get the point why
2.6.8.2 could be released after 2.6.9.

-- 
http://Processo.tk (1001 dias)
http://U-br.tk
Linux 2.6.7
São Paulo - SP

