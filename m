Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265157AbTFUMDW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 08:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265163AbTFUMDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 08:03:22 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:14791
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265157AbTFUMDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 08:03:22 -0400
Subject: Re: PROBLEM: 2.4.21 crashes hard running cdrecord in X.
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Con Kolivas <kernel@kolivas.org>
Cc: Per Nystrom <pnystrom@netmagic.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200306161055.13996.kernel@kolivas.org>
References: <1055722972.1502.39.camel@spike.sunnydale>
	 <200306161055.13996.kernel@kolivas.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056197708.25975.19.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 21 Jun 2003 13:15:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-06-16 at 01:55, Con Kolivas wrote:
> Could you please try without the nvidia drivers. You will get no support here 
> with them running. There is no way of knowing what happens when these are 
> running. They have our source code, we don't have theirs.

The IDE reset bug is one I know about. Its not the NV module for this
one, its mishandling of context for ide scsi timeouts.

