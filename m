Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVDRGM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVDRGM1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 02:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVDRGM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 02:12:27 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:18410 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261690AbVDRGMZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 02:12:25 -0400
X-ORBL: [67.124.119.21]
Date: Sun, 17 Apr 2005 23:12:21 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
Message-ID: <20050418061221.GA32315@taniwha.stupidest.org>
References: <4263275A.2020405@lab.ntt.co.jp> <20050418040718.GA31163@taniwha.stupidest.org> <4263356D.9080007@lab.ntt.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4263356D.9080007@lab.ntt.co.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 01:19:57PM +0900, Takashi Ikebe wrote:

> From our experience, sometimes patches became to dozens to hundreds
> at one patching, and in this case GDB based approach cause target
> process's availability descent.

i don't really buy that it can't be done or you complex patches are
necessary to be honest --- and there are various alternative APIs that
could help as others have pointed out


could you perhaps explain some *real* *world* applications/systems
where this is necessary and why existing APIs won't work with them
perhaps?

solving a real-world problem is much more interesting to listen to
that filling in a check-box on a (somewhat dubious) specification
