Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267362AbUHMU1y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267362AbUHMU1y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 16:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267477AbUHMUZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 16:25:45 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19895 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267447AbUHMUUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 16:20:01 -0400
Date: Fri, 13 Aug 2004 13:18:35 -0700
From: "David S. Miller" <davem@redhat.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: sam@ravnborg.org, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: __crc_* symbols in System.map
Message-Id: <20040813131835.4ea29bba.davem@redhat.com>
In-Reply-To: <20040813181042.GA9006@mars.ravnborg.org>
References: <20040811205529.1ff86e9d.davem@redhat.com>
	<20040812050136.GA7246@mars.ravnborg.org>
	<20040812000558.220d7e5d.davem@redhat.com>
	<20040813180239.GA7571@mars.ravnborg.org>
	<20040813181042.GA9006@mars.ravnborg.org>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2004 20:10:42 +0200
Sam Ravnborg <sam@ravnborg.org> wrote:

> On Fri, Aug 13, 2004 at 08:02:39PM +0200, Sam Ravnborg wrote:
> > 
> > $NM -n $1 | grep  '\( [aUw] \)\|\(__crc_\)' > $2
> 
> The missing -v ito grep was just to check if you were awake :-(

Final version looks good to me. :-)
Thanks Sam.
