Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266650AbSLPMiG>; Mon, 16 Dec 2002 07:38:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266654AbSLPMiG>; Mon, 16 Dec 2002 07:38:06 -0500
Received: from h55p111.delphi.afb.lu.se ([130.235.187.184]:3982 "EHLO
	gagarin.0x63.nu") by vger.kernel.org with ESMTP id <S266650AbSLPMiG>;
	Mon, 16 Dec 2002 07:38:06 -0500
Date: Mon, 16 Dec 2002 13:45:53 +0100
To: joe user <joe_user35@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: netstat and 2.5.5[12]
Message-ID: <20021216124553.GA3727@gagarin>
References: <F108c41W2ufyWOxbCJn0000a14c@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F108c41W2ufyWOxbCJn0000a14c@hotmail.com>
User-Agent: Mutt/1.4i
From: Anders Gustafsson <andersg@0x63.nu>
X-Scanner: exiscan *18Nud7-0001Cf-00*cYQoueTj.hU* (0x63.nu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 16, 2002 at 01:06:32PM +0100, joe user wrote:
> Is required a new net-tools package required to run 2.5.5[12]? If you run 
> netstat -t the process just hang forever, and is unkillable.

Happens here too.
http://marc.theaimsgroup.com/?l=linux-kernel&m=103974450111945&w=2

A cat /proc/net/tcp causes the same problem, so not tools problem.

-- 
Anders Gustafsson - andersg@0x63.nu - http://0x63.nu/
