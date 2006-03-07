Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964831AbWCGWog@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964831AbWCGWog (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 17:44:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964832AbWCGWof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 17:44:35 -0500
Received: from nproxy.gmail.com ([64.233.182.199]:13672 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964831AbWCGWof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 17:44:35 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=dceHETw6Gu0XedgHSkcqqL7Fbt2nbNjarg870+E3crim0WUwGgZAff25rqGI6oUDkSxBkah+cyepwPx3RfMa1BwFQMapb/ZG0/Wn9oHuJbxDQIrn+e94KP9w66hqdUWpXOcBVRspTZrA6ZjsGL1/eW7Vob/NOxlH/RvdsW/Bv8c=
Date: Wed, 8 Mar 2006 01:44:27 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christian Hopfensitz <c.hopfensitz@merkle-partner.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Kernel Bug mm/mmap.c:1956
Message-ID: <20060307224426.GA8353@mipter.zuzino.mipt.ru>
References: <D9CCF8787CFEEA4DA0C3FCFFD027AE24111488@SERVER2000.merkle-partner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9CCF8787CFEEA4DA0C3FCFFD027AE24111488@SERVER2000.merkle-partner.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2006 at 04:53:11PM +0100, Christian Hopfensitz wrote:
> [2.] kernel compiling is not possible on smp system. the job crashes. i used a script to test system stability with kernel compiling.

Just what level of stability have you expected after loading more than
4M of crap?

> Mar  7 16:11:20 jana kernel: Pid: 10979, comm: cc1 Tainted: P      2.6.15.4_CH-smp #1

> nvidia 4864944 12 - Live 0xffffffff882fc000

