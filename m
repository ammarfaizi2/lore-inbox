Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281024AbRLIBTf>; Sat, 8 Dec 2001 20:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281020AbRLIBTZ>; Sat, 8 Dec 2001 20:19:25 -0500
Received: from femail30.sdc1.sfba.home.com ([24.254.60.20]:35279 "EHLO
	femail30.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S281017AbRLIBTK>; Sat, 8 Dec 2001 20:19:10 -0500
Date: Sat, 8 Dec 2001 20:19:07 -0500
From: Tom Vier <tmv5@home.com>
To: linux-kernel@vger.kernel.org
Subject: [OT] fputc vs putc Re: horrible disk thorughput on itanium
Message-ID: <20011208201907.A937@zero>
In-Reply-To: <p73n10v6spi.fsf@amdsim2.suse.de> <20011207.124202.48805183.davem@redhat.com> <3C112DE4.60206@antefacto.com> <20011207.130316.39156883.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011207.130316.39156883.davem@redhat.com>; from davem@redhat.com on Fri, Dec 07, 2001 at 01:03:16PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 01:03:16PM -0800, David S. Miller wrote:
> They do it also for putc() if you haven't defined the appropriate
> defines.

what exactly is the difference between putc() and fputc()? the man page is
very vague.

-- 
Tom Vier <tmv5@home.com>
DSA Key id 0x27371A2C
