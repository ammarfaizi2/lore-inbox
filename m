Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263392AbTJ0CIq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 21:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263395AbTJ0CIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 21:08:46 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:48646
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263392AbTJ0CIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 21:08:46 -0500
Date: Sun, 26 Oct 2003 18:08:44 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: Transparent compression in the FS
Message-ID: <20031027020844.GC4511@matchmail.com>
Mail-Followup-To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
References: <1066163449.4286.4.camel@Borogove> <20031015133305.GF24799@bitwizard.nl> <3F8D6417.8050409@pobox.com> <20031016162926.GF1663@velociraptor.random> <20031016172930.GA5653@work.bitmover.com> <20031016174927.GB25836@speare5-1-14> <20031016230448.GA29279@pegasys.ws> <20031017094443.GA7738@elf.ucw.cz> <20031017182321.GB145@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031017182321.GB145@pegasys.ws>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17, 2003 at 11:23:21AM -0700, jw schultz wrote:
> The probability of false positives in rsync are orders of
> magnitude smaller than they would be in a block hashing
> filesystem.  Yet we were seeing it happen (with truncated
> hash) at measurable rates on files as small as a few hundred
> megabytes.  It was almost commonplace on iso images.

So has there been anything done to solve this problem in rsync?
