Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290666AbSAYMlJ>; Fri, 25 Jan 2002 07:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290664AbSAYMk7>; Fri, 25 Jan 2002 07:40:59 -0500
Received: from skunk.directfb.org ([212.84.236.169]:9963 "EHLO
	skunk.convergence.de") by vger.kernel.org with ESMTP
	id <S290662AbSAYMkp>; Fri, 25 Jan 2002 07:40:45 -0500
Date: Fri, 25 Jan 2002 13:40:05 +0100
From: Denis Oliver Kropp <dok@directfb.org>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Machine Check Exception ?
Message-ID: <20020125124005.GB15174@skunk.convergence.de>
Reply-To: Denis Oliver Kropp <dok@directfb.org>
In-Reply-To: <20020125114718.7af47375.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020125114718.7af47375.skraw@ithnet.com>
User-Agent: Mutt/1.3.26i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephan von Krawczynski (skraw@ithnet.com):
> Hello,
> 
> I get the following message under 2.2.19:
> 
> Message from syslogd@diehard at Thu Jan 24 14:44:49 2002 ...
> diehard kernel: CPU 0: Machine Check Exception: 0000000000000004

Hi,

I had the same error sometimes, during heavy load (compiling).
I replaced a memory module by another and it didn't crash anymore,
until now at least ;)

-- 
Best regards,
  Denis Oliver Kropp

.------------------------------------------.
| DirectFB - Hardware accelerated graphics |
| http://www.directfb.org/                 |
"------------------------------------------"

           convergence integrated media GmbH
