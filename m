Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263528AbTEMXtU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 19:49:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263542AbTEMXtU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 19:49:20 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20895
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263528AbTEMXsg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 19:48:36 -0400
Subject: Re: Vesa fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030513175022.GA3309@suse.de>
References: <Pine.LNX.4.44.0305122237300.14641-100000@phoenix.infradead.org>
	 <20030513175022.GA3309@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052866894.1206.16.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 May 2003 00:01:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-13 at 18:50, Dave Jones wrote:
> On Mon, May 12, 2003 at 10:44:29PM +0100, James Simmons wrote:
> 
>  >    The results of the EDID info from the BIOS has been varied. For some it 
>  > worked. Others it gave the wrong data. Then for other even the headers 
>  > where corrupted :-( 
> 
> XFree86 seems to do a pretty good job of getting it right, maybe they
> have blacklists ? Then again, this stuff is arguably better off done
> in userspace anyway IMO.

XFree handles EDID per driver and uses different methods in different
drivers.

