Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266983AbTAFOBT>; Mon, 6 Jan 2003 09:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266987AbTAFOBT>; Mon, 6 Jan 2003 09:01:19 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:47748
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266983AbTAFOBS>; Mon, 6 Jan 2003 09:01:18 -0500
Subject: Re: dummy ethernet driver
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dave Airlie <airlied@linux.ie>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0301060553260.24333-200000@skynet>
References: <Pine.LNX.4.44.0301060553260.24333-200000@skynet>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1041864865.17472.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 06 Jan 2003 14:54:25 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-01-06 at 05:57, Dave Airlie wrote:
> the patch is attached.. is there any reason why the dummy device doesn't
> want to do this stuff? I'm just submitting the patch as a request for
> comments on why this isn't done anyway in the dummy

If you want to talk to local systems why don't you use the netlink
interface/ethertap stuff ?

