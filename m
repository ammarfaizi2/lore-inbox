Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290667AbSAYNSF>; Fri, 25 Jan 2002 08:18:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290669AbSAYNRz>; Fri, 25 Jan 2002 08:17:55 -0500
Received: from ns.suse.de ([213.95.15.193]:15121 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290667AbSAYNRn>;
	Fri, 25 Jan 2002 08:17:43 -0500
Date: Fri, 25 Jan 2002 14:17:42 +0100
From: Dave Jones <davej@suse.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Machine Check Exception ?
Message-ID: <20020125141742.D28068@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Stephan von Krawczynski <skraw@ithnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020125114718.7af47375.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020125114718.7af47375.skraw@ithnet.com>; from skraw@ithnet.com on Fri, Jan 25, 2002 at 11:47:18AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2002 at 11:47:18AM +0100, Stephan von Krawczynski wrote:
 > Message from syslogd@diehard at Thu Jan 24 14:44:49 2002 ...
 > diehard kernel: CPU 0: Machine Check Exception: 0000000000000004
 > 
 > and the box is dead.
 > Can anybody please enlighten me what this means or what a possible
 > problem behind might be?

 Typically a hardware problem. Some older systems generate them
 spuriously though, which is why we have a "nomce" boot option.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
