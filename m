Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292981AbSB0WnD>; Wed, 27 Feb 2002 17:43:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293026AbSB0WmQ>; Wed, 27 Feb 2002 17:42:16 -0500
Received: from ns.suse.de ([213.95.15.193]:5390 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S293022AbSB0Wl4>;
	Wed, 27 Feb 2002 17:41:56 -0500
Date: Wed, 27 Feb 2002 23:41:55 +0100
From: Dave Jones <davej@suse.de>
To: James Curbo <jcurbo@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: (2.5.5-dj2) still getting .text.exit linker errors
Message-ID: <20020227234155.K16565@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	James Curbo <jcurbo@acm.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20020227220138.GA5644@carthage>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020227220138.GA5644@carthage>; from jcurbo@acm.org on Wed, Feb 27, 2002 at 04:01:38PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 27, 2002 at 04:01:38PM -0600, James Curbo wrote:
 > drivers/net/net.o(.data+0x1274): undefined reference to `local symbols 
 > in discarded section .text.exit'

 Can you grab http://kernelnewbies.org/scripts/reference_discarded.pl
 and post the output ?

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
