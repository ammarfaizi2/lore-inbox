Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135170AbREFIDo>; Sun, 6 May 2001 04:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135174AbREFIDe>; Sun, 6 May 2001 04:03:34 -0400
Received: from vitelus.com ([64.81.36.147]:15882 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S135170AbREFIDX>;
	Sun, 6 May 2001 04:03:23 -0400
Date: Sun, 6 May 2001 01:03:20 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Peter Rival <frival@zk3.dec.com>
Cc: Anton Blanchard <anton@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CPU hot swap for 2.4.3 + s390 support
Message-ID: <20010506010319.A10586@vitelus.com>
In-Reply-To: <20010505063726.A32232@va.samba.org> <3AF4118F.330C3E86@zk3.dec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <3AF4118F.330C3E86@zk3.dec.com>; from frival@zk3.dec.com on Sat, May 05, 2001 at 10:43:27AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 05, 2001 at 10:43:27AM -0400, Peter Rival wrote:
> Has anyone looked into memory hot swap/hot add support?

How do you hotswap RAM? What happens to the data that was on the
removed memory module?
