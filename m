Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313181AbSDINqh>; Tue, 9 Apr 2002 09:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313805AbSDINqg>; Tue, 9 Apr 2002 09:46:36 -0400
Received: from pc-80-195-35-22-ed.blueyonder.co.uk ([80.195.35.22]:42625 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S313181AbSDINqf>; Tue, 9 Apr 2002 09:46:35 -0400
Date: Tue, 9 Apr 2002 14:46:31 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: axp-kernel-list@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.4.9 and ABOVE
Message-ID: <20020409144631.J2807@redhat.com>
In-Reply-To: <003501c1dfc2$c1f28330$010b10ac@sbp.uptime.at> <003701c1dfc5$f31426a0$010b10ac@sbp.uptime.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Apr 09, 2002 at 02:56:17PM +0200, Oliver Pitzeier wrote:

> rm: cannot remove directory EXT3-fs error (device sd(8,18)):
> ext3_free_blocks: bit already cleared for block 1607322
> `linux/include/cEXT3-fs error (device sd(8,18)): ext3_free_blocks: bit
> already cleared for block 1607323

Is this captured console output or actual syslog contents?  Depending
on the log level, it's quite possible that there are kernel messages
which are going to one source or the other but not both.

--Stephen
