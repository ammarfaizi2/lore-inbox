Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263128AbUB0VDV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 16:03:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263108AbUB0VDV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 16:03:21 -0500
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:31882
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S263136AbUB0VCe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 16:02:34 -0500
Subject: Re: [PATCH] kill a dead function in lockd
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040227205623.GA20398@lst.de>
References: <20040227205623.GA20398@lst.de>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1077915747.5728.13.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 13:02:28 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På fr , 27/02/2004 klokka 12:56, skreiv Christoph Hellwig:
> sleep_on hurts my eyes and this offender is compltely unused, so..
> 

Agreed. Kill it...

Cheers,
  Trond
