Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265249AbTABQq0>; Thu, 2 Jan 2003 11:46:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265262AbTABQq0>; Thu, 2 Jan 2003 11:46:26 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:6792
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S265249AbTABQqY>; Thu, 2 Jan 2003 11:46:24 -0500
Subject: Re: [OT] Re: Why is Nvidia given GPL'd code to use in closed source
	drivers?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Milosz Tanski <mtanski@wideopenwest.com>
Cc: david.lang@digitalinsight.com, paul@clubi.ie, riel@conectiva.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, rms@gnu.org
In-Reply-To: <20030102013405.4f0d3417.mtanski@wideopenwest.com>
References: <0a5713612060213DTVMAIL4@smtp.cwctv.net> 
	<20030102013405.4f0d3417.mtanski@wideopenwest.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 02 Jan 2003 17:37:39 +0000
Message-Id: <1041529059.24829.13.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-02 at 06:34, Milosz Tanski wrote:
> There is (was) an effort for opensource 3d drivers (including nvidia
> ones), infact i rember they got quake II and III working in 32bit color
> mode, if i rember correctly. If you go grieff, then go visit
> http://utah-glx.sourceforge.net/ and help out. Make the drivers better
> then the nvidia ones (ya right!) so they will be forced to use your code
> on other paltforms (and then nvidia would be forced to use it, and thus
> open up their code). I'll see you in two years, when you fully complete
> the drivers? Ok, bye. 
> 
> P.S: I think the code there is under a BSD (BSDish, MITish licence,

Utah-GLX supports the older Nvidia cards, and works in XFree86 4.2 at
least - although since its based on an older Mesa not all stuff works
well with it.

Alan

