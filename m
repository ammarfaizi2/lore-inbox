Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263380AbUJ2PiN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbUJ2PiN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 11:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263384AbUJ2Pf4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 11:35:56 -0400
Received: from host-3.tebibyte16-2.demon.nl ([82.161.9.107]:56837 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S263367AbUJ2OsH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 10:48:07 -0400
Message-ID: <418257E3.2000606@tebibyte.org>
Date: Fri, 29 Oct 2004 16:46:59 +0200
From: Chris Ross <chris@tebibyte.org>
Organization: At home (Eindhoven, The Netherlands)
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@osdl.org>,
       javier@marcet.info, linux-kernel@vger.kernel.org, kernel@kolivas.org,
       barry <barry@disus.com>
Subject: Re: Mem issues in 2.6.9 (ever since 2.6.9-rc3) and possible cause
References: <Pine.LNX.4.44.0410251823230.21539-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.44.0410251833210.21539-100000@chimarrao.boston.redhat.com> <20041028120650.GD5741@logos.cnet> <41824760.7010703@tebibyte.org>
In-Reply-To: <41824760.7010703@tebibyte.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Chris Ross escreveu:
> Testing again: on plain 2.6.10-rc1-mm2 (i.e. without Rik's patch) 
> building umlsim fails on my 64MB P2 350MHz Gentoo box exactly as before.

To confirm, 2.6.10-rc1-mm2 with Rik's patch compiles umlsim-65 
(http://umlsim.sourceforge.net/umlsim-65.tar.gz) just fine.

Regards,
Chris R.
