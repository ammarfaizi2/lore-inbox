Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbTH2SdZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 14:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbTH2SdZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 14:33:25 -0400
Received: from pirx.hexapodia.org ([208.42.114.113]:13865 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S261482AbTH2SdY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 14:33:24 -0400
Date: Fri, 29 Aug 2003 13:33:23 -0500
From: Andy Isaacson <adi@hexapodia.org>
To: linux-kernel@vger.kernel.org
Subject: Re: mutt segfault with ext3 & 1k blocks & htree in 2.6
Message-ID: <20030829133323.E16285@hexapodia.org>
References: <20030829172451.GA27023@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030829172451.GA27023@matchmail.com>; from mfedyk@matchmail.com on Fri, Aug 29, 2003 at 10:24:51AM -0700
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 10:24:51AM -0700, Mike Fedyk wrote:
> I have just converted my 25GB / partition from reiserfs to ext3 with 1k
> blocks, and now mutt is segfaulting periodocally.
[snip]
> I have full strace output of each mutt process up until the segfault in two
> cases, and up until strace was stopped in the third case.

The obvious request is "turn on core dumps and get a backtrace".

-andy
