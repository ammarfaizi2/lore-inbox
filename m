Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266774AbSKHQbD>; Fri, 8 Nov 2002 11:31:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266779AbSKHQbD>; Fri, 8 Nov 2002 11:31:03 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:16796 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266774AbSKHQbC>; Fri, 8 Nov 2002 11:31:02 -0500
Subject: Re: [PATCH] Linux-streams registration 2.5.46
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Rob Landley <landley@trommello.org>
Cc: David Grothe <dave@gcom.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200211080637.06511.landley@trommello.org>
References: <5.1.0.14.2.20021107145447.027905c8@localhost> 
	<200211080637.06511.landley@trommello.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Nov 2002 17:00:51 +0000
Message-Id: <1036774851.16898.22.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-08 at 06:37, Rob Landley wrote:
> > Comments welcome.  If it looks good will someone tell me to whom to direct
> > it for inclusion in the kernel source?
> 
> Just a random comment, but the feature freeze was October 31st.  Is this a 
> repost of something we saw before then?

Its just a fix for something that was broken before by cleanups and is
now being done right. It also has no impact on drivers and other stuff.

Dim prob

