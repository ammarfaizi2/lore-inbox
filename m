Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271372AbTGQLjU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 07:39:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271375AbTGQLjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 07:39:20 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:18894
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S271372AbTGQLjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 07:39:19 -0400
Subject: Re: Error compiling, scsi 2.6.0-test1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: backblue <backblue@netcabo.pt>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030716232827.2272eccb.backblue@netcabo.pt>
References: <Sea2-F42G9i3HGRgKuw00017dcf@hotmail.com>
	 <ODEIIOAOPGGCDIKEOPILAEBDCNAA.alan@storlinksemi.com>
	 <20030716232827.2272eccb.backblue@netcabo.pt>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058442701.8621.26.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 17 Jul 2003 12:51:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-07-16 at 23:28, backblue wrote:
> I have gcc 3.3, on x86 machine, i have this error, compiling the suport for my scsi card, someone know the problem?

Nobody has coverted this driver to 2.6 yet. If someone does then it will
get merged in, if not the initio support will get deleted in time.

