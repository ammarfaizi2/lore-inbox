Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316204AbSEZW2u>; Sun, 26 May 2002 18:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316263AbSEZW2t>; Sun, 26 May 2002 18:28:49 -0400
Received: from pop015pub.verizon.net ([206.46.170.172]:38652 "EHLO
	pop015.verizon.net") by vger.kernel.org with ESMTP
	id <S316204AbSEZW2t>; Sun, 26 May 2002 18:28:49 -0400
Date: Sun, 26 May 2002 18:32:51 -0400
From: Skip Ford <skip.ford@verizon.net>
To: Sebastian Droege <sebastian.droege@gmx.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.18 ide-scsi compile fix
Mail-Followup-To: Sebastian Droege <sebastian.droege@gmx.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3CEF8815.C7C13D39@wxs.nl> <3CEFAB05.62937A75@wxs.nl> <20020526135058.493da149.sebastian.droege@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Message-Id: <20020526222844.HWX25262.pop015.verizon.net@pool-141-150-239-239.delv.east.verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sebastian Droege wrote:
> 
> BTW: why do I get an oops (reported 2 or 3 times but no answers)
> when mounting cdroms since 2.5.7 or something?

Because the ide-scsi code hasn't caught up to Martin's IDE cleanup
changes yet.

-- 
Skip
