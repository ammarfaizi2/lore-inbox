Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318329AbSG3Q3l>; Tue, 30 Jul 2002 12:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318337AbSG3Q3l>; Tue, 30 Jul 2002 12:29:41 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:62702 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318329AbSG3Q3k>; Tue, 30 Jul 2002 12:29:40 -0400
Subject: Re: rc3-ac4 compilation error
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Diego Calleja <diegocg@teleline.es>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020730155649.7ed5253b.diegocg@teleline.es>
References: <20020730155649.7ed5253b.diegocg@teleline.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 30 Jul 2002 18:49:15 +0100
Message-Id: <1028051355.7974.10.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-07-30 at 14:56, Diego Calleja wrote:
> i've found a compilation error:
> 
> 
> The problem seems to be in this changes from the -rc3-ac4 patch :
> (in the drivers/char/drm/drmP.h)

You need a better compiler - or try ac5 which hopefully has stuff
working again with egcs-1.1.2 and gcc 2.95


