Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264034AbUDSLNa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 07:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264346AbUDSLNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 07:13:30 -0400
Received: from gstserv.netnea.com ([213.200.225.210]:26459 "EHLO
	james.netnea.com") by vger.kernel.org with ESMTP id S264034AbUDSLN2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 07:13:28 -0400
Date: Mon, 19 Apr 2004 08:23:35 +0200
From: Charles Bueche <charles@bueche.ch>
To: linux-kernel@vger.kernel.org
Cc: vcjones@NetworkingUnlimited.com (Vincent C Jones), kevin@scrye.com
Subject: Re: 2.6.5, ACPI, suspend and ThinkPad R40
Message-Id: <20040419082335.6b10bdd9@bluez.bueche.ch>
In-Reply-To: <20040406131602.CCED21421B@x23.networkingunlimited.com>
References: <1HjUX-5pa-3@gated-at.bofh.it>
	<1HnYA-hr-9@gated-at.bofh.it>
	<1HKVd-1Uf-3@gated-at.bofh.it>
	<20040406131602.CCED21421B@x23.networkingunlimited.com>
X-Mailer: Sylpheed version 0.9.10claws (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: $|Nk/@TgZ5o#.yMqN*6c'4p/618&z3u~2V8.*td7vyVp9lPIy!O@{.bF+/o["H-00Fxfh3E|X"G|[K7y(aN\\BZ^'J#\"1u2&Qbe'8l<{3qBqy|R/_s_8o5fVUjg@dZ'E\tf_u^{;{g%*/6Glu!-~D\#,Gw_TD&p'mURwR2AnKX"!FSB#b&CD`0\ZEp52#W-z`Z~b2lPwv~de]a01M[&e+SwzgeIwtGaPp@@6pK=4?a0d9rVYnGs(Cf
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  6 Apr 2004 09:16:02 -0400 (EDT)
vcjones@NetworkingUnlimited.com (Vincent C Jones) wrote:
> Is it my imagination or is there an acute lack of interest in
> supporting notebook features in 2.6.X? Since the early days of 2.5.X,
> there have been questions raised regarding suspend/resume and related
> questions of critical importance to mobile users. All (at least those
> associated with IBM ThinkPads) have been ignored by developers, with
> the only responses coming from other notebook users expressing similar
> concerns.

I can add my "me-too" here. I own a Dell I8600 which perform excellently
in gentoo with 2.6.x, with the only remaining issue being
suspend+resume.

I have tried several times to understand this ACPI thing, only to find
that the KISS principle has been forgotten when it has been designed.
Maybe it's simply not possible to design something"acceptably simple" in
this business, but the fact that Alan Cox has called it "terminally
broken" tend to support my point of view.

My intend is not to start a flamewar here, but with laptop HW coming
down in price, we have to provide a better support for casual users. 

I can't contribute code here, but I can test things you throw at me for
Dell I8600, so feel free.

Charles

-- 
Charles Bueche <charles@bueche.ch>
sand, snow, wave, wind and net -surfer
