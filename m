Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266039AbTFWNwc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 09:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266042AbTFWNwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 09:52:31 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:29136
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S266039AbTFWNwb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 09:52:31 -0400
Subject: Re: Broadcom bcm 4401
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030623151040.135133f9.skraw@ithnet.com>
References: <20030623151040.135133f9.skraw@ithnet.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056377068.13529.41.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Jun 2003 15:04:29 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-06-23 at 14:10, Stephan von Krawczynski wrote:
> Hello all,
> 
> does anybody know what drivers are available for BCM4401 network cards? Are
> they somehow compatible to whatever?

There is a broadcom b44 driver in -ac, but it needs a lot more cleaning
up or rewriting before it goes anywhere further

