Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132958AbRD2TX4>; Sun, 29 Apr 2001 15:23:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136045AbRD2TXq>; Sun, 29 Apr 2001 15:23:46 -0400
Received: from adsl-64-163-64-75.dsl.snfc21.pacbell.net ([64.163.64.75]:2052
	"EHLO konerding.com") by vger.kernel.org with ESMTP
	id <S132958AbRD2TXZ>; Sun, 29 Apr 2001 15:23:25 -0400
Message-ID: <3AEC6A23.4844DC4C@konerding.com>
Date: Sun, 29 Apr 2001 12:23:15 -0700
From: David Konerding <dek_ml@konerding.com>
X-Mailer: Mozilla 4.73 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: traceroute breaks with 2.4.4
In-Reply-To: <3AEBE142.E3CAD85E@konerding.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Konerding wrote:

> As far as I can tell, somewhere between 2.4.2 and 2.4.4, traceroute
> stopped working.
> I see the problem on RH7.x.  Regular kernel compile with near-defaults
> for networking,
> no firewalling is enabled.  Rebootiing to a similar config under 2.4.2
> works OK.

OK, I'm unable to fix this by reverting to 2.4.2 using the same config as
2.4.2.
However, an older compiled 2.4.2 worked, so I think I must have changed
some configuration which affects it.  Can't for the life of me figure out what
it is,
tho'.

Dave

