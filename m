Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274878AbTHKVr6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 17:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274880AbTHKVr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 17:47:58 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:65164
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S274878AbTHKVr5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 17:47:57 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]O14int [SCHED_SOFTRR please]
Date: Tue, 12 Aug 2003 07:53:28 +1000
User-Agent: KMail/1.5.3
References: <200308091036.18208.kernel@kolivas.org> <5.2.1.1.2.20030810122144.019bdb00@pop.gmx.net> <200308112019.38613.roger.larsson@skelleftea.mail.telia.com>
In-Reply-To: <200308112019.38613.roger.larsson@skelleftea.mail.telia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308120753.28814.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Aug 2003 04:19, Roger Larsson wrote:
> xmms is a RT process - it does not really have interactivity problems...
> It will be extremely hard to fix this in a generic scheduler, instead
> let xmms be the RT process it is with SCHED_SOFTRR (or whatever
> it will be named).

Have you actually _tried_ the tweaked generic scheduler before this big claim?

Con

