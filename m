Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264446AbUBIJ3Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 04:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264449AbUBIJ3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 04:29:16 -0500
Received: from userbb201.dsl.pipex.com ([62.190.241.201]:20446 "EHLO
	irishsea.home.craig-wood.com") by vger.kernel.org with ESMTP
	id S264446AbUBIJ3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 04:29:16 -0500
Date: Mon, 9 Feb 2004 09:29:15 +0000
From: Nick Craig-Wood <ncw1@axis.demon.co.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Does anyone still care about BSD ptys?
Message-ID: <20040209092915.GA11305@axis.demon.co.uk>
References: <c07c67$vrs$1@terminus.zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c07c67$vrs$1@terminus.zytor.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 09, 2004 at 07:17:27AM +0000, H. Peter Anvin wrote:
> Does anyone still care about old-style BSD ptys, i.e. /dev/pty*?

I use them quite a lot for testing serial port stuff in shell scripts,
eg connect one process which expects a serial port to /dev/ttys0 and
another to /dev/ptys0.  I expect there is a sane way of doing this new
style pty's - I just don't know it!

-- 
Nick Craig-Wood
ncw1@axis.demon.co.uk
