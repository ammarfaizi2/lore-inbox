Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262039AbVCUVk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262039AbVCUVk2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 16:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261976AbVCUVLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 16:11:21 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:58246 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S261915AbVCUU7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 15:59:22 -0500
Date: Mon, 21 Mar 2005 21:59:15 +0100
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Problems with connect/disconnect cycles
Message-ID: <20050321205915.GA29072@gamma.logic.tuwien.ac.at>
References: <20050321090537.GI14614@gamma.logic.tuwien.ac.at> <Pine.LNX.4.44L0.0503211513090.2329-100000@ida.rowland.org> <20050321203240.GA26901@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050321203240.GA26901@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan!

On Mon, 21 Mär 2005, preining wrote:
> I will try 2.6.10-mm3 where I have a home made .deb lying around and
> will report back.

I tried with 2.6.10-mm3 but couldn't find any instance of the problem:
BUT: I couldn't find it in the short time here now also with 2.6.11-mm4.

I skimmed over all my logrotated syslog files and found that in *most*
cases (but not all, at least I believe I saw another case, too) the
disconnect/reconnect cycles appeared when the laptop was running on
battery.

Does this ring any bell maybe?

I will try to give 2.6.10-mm3 and 2.6.12-rc1-mm1 a longer testing time
tomorrow, but now I have to go to bed.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>                 Università di Siena
sip:preining@at43.tuwien.ac.at                             +43 (0) 59966-690018
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
LUTON (n.)
The horseshoe-shaped rug which goes around a lavatory seat.
			--- Douglas Adams, The Meaning of Liff
