Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318379AbSGRVfG>; Thu, 18 Jul 2002 17:35:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318380AbSGRVfG>; Thu, 18 Jul 2002 17:35:06 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:41209 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318379AbSGRVfG>; Thu, 18 Jul 2002 17:35:06 -0400
Subject: Re: Generic modules documentation is outdated
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Yann Dirson <ydirson@altern.org>
Cc: linux-kernel@vger.kernel.org, kaos@ocs.com.au
In-Reply-To: <20020718210259.GJ19580@bylbo.nowhere.earth>
References: <20020704212240.GB659@bylbo.nowhere.earth> 
	<20020718210259.GJ19580@bylbo.nowhere.earth>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 18 Jul 2002 23:48:41 +0100
Message-Id: <1027032521.8154.48.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-07-18 at 22:02, Yann Dirson wrote:
> - I have installed no proprietary driver, all loaded drivers declare to be
> "GPL" or "Dual BSD/GPL". 

Something you loaded was missing a MODULE_LICENSE tag - modern insmod
will warn on this one

