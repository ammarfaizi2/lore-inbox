Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261292AbTBMXhA>; Thu, 13 Feb 2003 18:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268142AbTBMXhA>; Thu, 13 Feb 2003 18:37:00 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:31109
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261292AbTBMXg7>; Thu, 13 Feb 2003 18:36:59 -0500
Subject: Re: Question about 48 bit IDE on 2.4.18 kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Larry Hileman <LHileman@snapappliance.com>
Cc: Linux Kernel "Maillist (E-mail)" <linux-kernel@vger.kernel.org>
In-Reply-To: <057889C7F1E5D61193620002A537E8690B5A29@NCBDC>
References: <057889C7F1E5D61193620002A537E8690B5A29@NCBDC>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045183646.7090.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 14 Feb 2003 00:47:27 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-13 at 23:27, Larry Hileman wrote:
> I would expect that the CMD680 and CSB6 drivers have been updated since
> the 2.4.18 kernel.  Can someone let me know where I can find the most
> recent drivers.  I have checked the sources I know for the latest driver and
> not had any luck.  I was hoping someone may have a better set of sources.

The 2.4.20/21predrivers support LBA48

