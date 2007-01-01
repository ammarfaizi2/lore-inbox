Return-Path: <linux-kernel-owner+w=401wt.eu-S1753655AbXAATNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753655AbXAATNe (ORCPT <rfc822;w@1wt.eu>);
	Mon, 1 Jan 2007 14:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753633AbXAATNe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Jan 2007 14:13:34 -0500
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:32449 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753635AbXAATNd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Jan 2007 14:13:33 -0500
Date: Mon, 1 Jan 2007 19:13:29 +0000
From: Ken Moffat <zarniwhoop@ntlworld.com>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: x86 instability with 2.6.1{8,9}
Message-ID: <20070101191329.GA29826@deepthought>
References: <20070101160158.GA26547@deepthought> <200701011648.55460.s0348365@sms.ed.ac.uk> <20070101170758.GA28015@deepthought>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20070101170758.GA28015@deepthought>
User-Agent: Mutt/1.5.12-2006-07-14
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 01, 2007 at 05:07:58PM +0000, Ken Moffat wrote:
> On Mon, Jan 01, 2007 at 04:48:55PM +0000, Alistair John Strachan wrote:
> > 
> > Obviously papering over a severe bug, but why is it necessary for you to run a 
> > 32bit kernel to test 32bit userspace? If your 64bit kernel is stable, use the 
> > IA32 emulation surely?
> > 
>  My 64-bit is pure64 on this machine, so it doesn't have any
> suitable libs or tools.  Anyway, I really do need a 32-bit kernel
> to test some linuxfromscratch build instructions.
> 
 Sorry, I think last night is still interfering with my own logic
circuits.  Yes, I could use 'linux32' to change the personality as a
work-around now that I've built the system.  Mainly, I was hoping
somebody would notice something bad in the config, but I might use
the work-around in the meantime.  Thanks for reminding me about it.

Ken
-- 
das eine Mal als Tragödie, das andere Mal als Farce
