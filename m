Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288511AbSAQLRp>; Thu, 17 Jan 2002 06:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288531AbSAQLRf>; Thu, 17 Jan 2002 06:17:35 -0500
Received: from ns.suse.de ([213.95.15.193]:56333 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288512AbSAQLRZ>;
	Thu, 17 Jan 2002 06:17:25 -0500
Date: Thu, 17 Jan 2002 12:17:23 +0100
From: Dave Jones <davej@suse.de>
To: "Eric S. Raymond" <esr@thyrsus.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Calling EISA experts
Message-ID: <20020117121723.B22171@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020117015456.A628@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020117015456.A628@thyrsus.com>; from esr@thyrsus.com on Thu, Jan 17, 2002 at 01:54:56AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2002 at 01:54:56AM -0500, Eric S. Raymond wrote:
 > Does anything in /proc or elswhere reliably register the presence of EISA?  

 Not afaik. I'm tempted to hack support for it into driverfs.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
