Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267472AbTA3KjX>; Thu, 30 Jan 2003 05:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267474AbTA3KjX>; Thu, 30 Jan 2003 05:39:23 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:31877
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267472AbTA3KjW>; Thu, 30 Jan 2003 05:39:22 -0500
Subject: Re: Linux 2.4.21-pre4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Thomas Davis <tadavis@lbl.gov>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <3E384D41.9080605@lbl.gov>
References: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>
	 <3E384D41.9080605@lbl.gov>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043926998.28133.21.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 30 Jan 2003 11:43:18 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-01-29 at 21:53, Thomas Davis wrote:
> This simple one line patch adds the missing ac97 support that the fm801 
> driver already uses.

FM801 is a card not a codec

