Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbTDCRQs 
	(for <rfc822;willy@w.ods.org>); Thu, 3 Apr 2003 12:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id S261359AbTDCRQr 
	(for <rfc822;linux-kernel-outgoing>); Thu, 3 Apr 2003 12:16:47 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:20613
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261351AbTDCRQm 
	(for <rfc822;linux-kernel@vger.kernel.org>); Thu, 3 Apr 2003 12:16:42 -0500
Subject: Re: [Linux-fbdev-devel] [PATCH]: EDID parser
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sven Luther <luther@dpt-info.u-strasbg.fr>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Petr Vandrovec <VANDROVE@vc.cvut.cz>,
       James Simmons <jsimmons@infradead.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030403171820.GE1092@iliana>
References: <1049383273.11742.0.camel@dhcp22.swansea.linux.org.uk>
	 <Pine.GSO.4.21.0304031831030.23642-100000@vervain.sonytel.be>
	 <20030403171009.GC1092@iliana>
	 <1049386531.11747.32.camel@dhcp22.swansea.linux.org.uk>
	 <20030403171820.GE1092@iliana>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049387372.11742.38.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 03 Apr 2003 17:29:33 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-04-03 at 18:18, Sven Luther wrote:
> So, using the terminology of Petr's graph, you have only one CRTC, with
> two possible outputs, or maybe you have two CRTC but which needs to be
> synchronized between them ?

The EPIA seems to support both outputs at once so I would assume it has
two CRTC's while the old SIS can do only one at a time so it may be a 
switch.

