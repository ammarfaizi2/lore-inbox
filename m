Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267558AbTBUQTu>; Fri, 21 Feb 2003 11:19:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267559AbTBUQTt>; Fri, 21 Feb 2003 11:19:49 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:10121
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267558AbTBUQTt>; Fri, 21 Feb 2003 11:19:49 -0500
Subject: Re: 2.4 series IDE troubles
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: shoninnaive@sbcglobal.net
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030221080120.45d30fec.home@lfs.pitchblende.org>
References: <20030221080120.45d30fec.home@lfs.pitchblende.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1045848644.5275.58.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 21 Feb 2003 17:30:45 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-02-21 at 13:01, j wrote:
> least from what I see in searchs on these errors. Usually the problem
> is blamed on the user and they are asked hundreds of irritating questions about hardware and configuration.
> 

And without that information there is no way to fix it. At a first guess 
you've stuck an IDE master and a flash slave via an adapter on the same
cable. 

