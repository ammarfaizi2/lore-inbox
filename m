Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290669AbSAYN1z>; Fri, 25 Jan 2002 08:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290673AbSAYN1p>; Fri, 25 Jan 2002 08:27:45 -0500
Received: from skunk.directfb.org ([212.84.236.169]:46315 "EHLO
	skunk.convergence.de") by vger.kernel.org with ESMTP
	id <S290669AbSAYN1h>; Fri, 25 Jan 2002 08:27:37 -0500
Date: Fri, 25 Jan 2002 14:26:58 +0100
From: Denis Oliver Kropp <dok@directfb.org>
To: Dave Jones <davej@suse.de>, Stephan von Krawczynski <skraw@ithnet.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Machine Check Exception ?
Message-ID: <20020125132658.GA15769@skunk.convergence.de>
Reply-To: Denis Oliver Kropp <dok@directfb.org>
In-Reply-To: <20020125114718.7af47375.skraw@ithnet.com> <20020125141742.D28068@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020125141742.D28068@suse.de>
User-Agent: Mutt/1.3.26i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dave Jones (davej@suse.de):
> On Fri, Jan 25, 2002 at 11:47:18AM +0100, Stephan von Krawczynski wrote:
>  > Message from syslogd@diehard at Thu Jan 24 14:44:49 2002 ...
>  > diehard kernel: CPU 0: Machine Check Exception: 0000000000000004
>  > 
>  > and the box is dead.
>  > Can anybody please enlighten me what this means or what a possible
>  > problem behind might be?
> 
>  Typically a hardware problem. Some older systems generate them
>  spuriously though, which is why we have a "nomce" boot option.

My system here is a P3 800 Coppermine with Infineon RAM.
After removing that module it didn't occur. Linux 2.4.17.

-- 
Best regards,
  Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"

           convergence integrated media GmbH
