Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266951AbTGGLco (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 07:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266952AbTGGLco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 07:32:44 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:9641
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S266951AbTGGLcn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 07:32:43 -0400
Subject: Re: 2.4.22-pre3 : SoundBlaster IDE interface missing
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ben Castricum <lk@bencastricum.nl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <000901c343df$9165ed10$0802a8c0@pc>
References: <000901c343df$9165ed10$0802a8c0@pc>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057578275.2749.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Jul 2003 12:44:36 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-07-06 at 17:56, Ben Castricum wrote:
> I have one of those ancients ISA-PNP SoundBlaster cards with an additional
> IDE interface on it. It all worked perfectly up till 2.4.22-pre2 but with
> pre3 the IDE interface is no longer detected.

Oops. I have redone the initialization for the ISAPnP IDE devices so its
quite possible I got this bit wrong. I'll take a look at it
today/tomorrow see why its vanished.

