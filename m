Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270655AbTGNO54 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 10:57:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270634AbTGNO5z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 10:57:55 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34754
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270647AbTGNOzo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 10:55:44 -0400
Subject: Re: Linux v2.6.0-test1
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: John Bradford <john@grabjohn.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
In-Reply-To: <Pine.LNX.4.55L.0307141055530.18257@freak.distro.conectiva>
References: <200307141139.h6EBd09g000700@81-2-122-30.bradfords.org.uk>
	 <1058182417.561.47.camel@dhcp22.swansea.linux.org.uk>
	 <Pine.LNX.4.55L.0307141055530.18257@freak.distro.conectiva>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058195269.561.72.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jul 2003 16:07:50 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-07-14 at 14:56, Marcelo Tosatti wrote:
> > Then you'll just have to wait a few months
> 
> I will start looking at 2.4 security fixes which are not applied in 2.6.
> 
> If someone is already doing that, please tell me.

I'm working on the recent exec and proc stuff. strncpy needs people who can
do their native asm though.

