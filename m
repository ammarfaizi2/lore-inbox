Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261900AbVDCVX0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261900AbVDCVX0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 17:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261903AbVDCVX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 17:23:26 -0400
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:48552
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261900AbVDCVXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 17:23:23 -0400
Date: Sun, 3 Apr 2005 14:22:35 -0700
From: "David S. Miller" <davem@davemloft.net>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: James.Bottomley@SteelEye.com, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix boot hang on some architectures
Message-Id: <20050403142235.35f7bd01.davem@davemloft.net>
In-Reply-To: <20050403152101.GC640@conectiva.com.br>
References: <1112471164.5786.23.camel@mulgrave>
	<20050403152101.GC640@conectiva.com.br>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Apr 2005 12:21:01 -0300
Arnaldo Carvalho de Melo <acme@conectiva.com.br> wrote:

> Em Sat, Apr 02, 2005 at 01:46:03PM -0600, James Bottomley escreveu:
> > Well, this is a brown paper bag for someone.  The new protocol
> 
> /me using such bag now :(
> 
> Thanks a lot for the fix.
> 
> David, Please apply.

Done, thanks everyone.
