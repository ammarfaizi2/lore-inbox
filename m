Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262527AbVCDIDl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbVCDIDl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 03:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262619AbVCDIDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 03:03:41 -0500
Received: from mail.portrix.net ([212.202.157.208]:16038 "EHLO
	zoidberg.portrix.net") by vger.kernel.org with ESMTP
	id S262527AbVCDIDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 03:03:35 -0500
Message-ID: <42281626.8010306@ppp0.net>
Date: Fri, 04 Mar 2005 09:02:46 +0100
From: Jan Dittmer <jdittmer@ppp0.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050116 Thunderbird/1.0 Mnenhy/0.6.0.104
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew James Wade 
	<ajwade@cpe0020e06a7211-cm0011ae8cd564.cpe.net.cable.rogers.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org> <20050302165830.0a74b85c.davem@davemloft.net> <200503022114.20214.gene.heskett@verizon.net> <200503032223.05172.ajwade@cpe0020e06a7211-cm0011ae8cd564.cpe.net.cable.rogers.com>
In-Reply-To: <200503032223.05172.ajwade@cpe0020e06a7211-cm0011ae8cd564.cpe.net.cable.rogers.com>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew James Wade wrote:
> I've just done a bit of looking for scripts to automate the process of
> installing a new kernel, and I haven't come up with much of much. So
> right now I'm writing my own. If there are tools to help automate this
> they need to be more prominent on www.kernel.org and
> www.kernelnewbies.org, to make casual testing even easier.

Try ketchup from here: http://www.selenic.com/ketchup/
`ketchup 2.6-mm` for example will download and patch the newest 2.6-mm
kernel (also try ketchup 2.6-pre, ketchup 2.6-bk, ...).

Jan

-- 
http://l4x.org/k/
