Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261817AbVCHGjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261817AbVCHGjV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 01:39:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261822AbVCHGjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 01:39:20 -0500
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:39637 "HELO
	develer.com") by vger.kernel.org with SMTP id S261821AbVCHGiK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 01:38:10 -0500
Message-ID: <422D485F.5060709@develer.com>
Date: Tue, 08 Mar 2005 07:38:23 +0100
From: Bernardo Innocenti <bernie@develer.com>
User-Agent: Mozilla Thunderbird  (X11/20041216)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Trond Myklebust <trond.myklebust@fys.uio.no>
CC: lkml <linux-kernel@vger.kernel.org>,
       Neil Conway <nconway_kernel@yahoo.co.uk>, nfs@lists.sourceforge.net
Subject: Re: NFS client bug in 2.6.8-2.6.11
References: <422D2FDE.2090104@develer.com> <1110259831.11712.1.camel@lade.trondhjem.org>
In-Reply-To: <1110259831.11712.1.camel@lade.trondhjem.org>
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> ty den 08.03.2005 Klokka 05:53 (+0100) skreiv Bernardo Innocenti:
> 
>>Appears to be a client bug.
> 
> Why?

Two clients started showing the problem after
being upgraded from FC2 to FC3, while the server
remained unchanged.

I also can't reproduce the problem on an older
client running 2.4.21.

I'll test with 2.6.7 as soon as I can reboot the
client I'm using right now.

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

