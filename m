Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268258AbUJDQpL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268258AbUJDQpL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 12:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268271AbUJDQpK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 12:45:10 -0400
Received: from cantor.suse.de ([195.135.220.2]:14283 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268258AbUJDQpH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 12:45:07 -0400
Message-ID: <41617DB8.5030705@suse.de>
Date: Mon, 04 Oct 2004 18:43:36 +0200
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>, Mitch <Mitch@0Bits.COM>
Cc: ottdot@magma.ca, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3 software suspend (pmdisk) stopped working
References: <416030C0.8090900@0Bits.COM> <20041004104350.GA3833@openzaurus.ucw.cz>
In-Reply-To: <20041004104350.GA3833@openzaurus.ucw.cz>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Pavel Machek wrote:
> Hi!

> I do not
> know what is wrong with that disk file, it looks like a bug.

reading /sys/power/disk gives you the _active_ state, not the available 
states.

HTH,
        Stefan
