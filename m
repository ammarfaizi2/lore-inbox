Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266379AbUHRORm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266379AbUHRORm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 10:17:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266304AbUHRORl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 10:17:41 -0400
Received: from anor.ics.muni.cz ([147.251.4.35]:35227 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S266379AbUHRORb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 10:17:31 -0400
Date: Wed, 18 Aug 2004 16:17:23 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Michael Geithe <warpy@gmx.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel 2.6.8.1 and Minolta Dimage-7HI
Message-ID: <20040818141723.GD10239@fi.muni.cz>
References: <200408172045.16386.warpy@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200408172045.16386.warpy@gmx.de>
User-Agent: Mutt/1.4.2i
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Geithe wrote:
: My Minolta Dimage-7HI will not work with the latest 2.6.8.1 and 2.6.8.1-mm1 
: Kernel.
: 
	The same here, Fedora Core 2 (gcc 3.3.3).

Does not work: 2.6.8-rc2, -rc3 and 2.6.8.1
Works OK: 2.6.3 (did not tested anything between).

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
btw, David, I'm wondering about this loop: [...]  Is this
a busy-wait-until-someone-plugs-in-more-ram-chips thing? ;)  --Andrew Morton
