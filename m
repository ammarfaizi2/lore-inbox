Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265988AbUAKVJI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 16:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265989AbUAKVJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 16:09:08 -0500
Received: from pcp05127596pcs.sanarb01.mi.comcast.net ([68.42.103.198]:59026
	"EHLO nidelv.trondhjem.org") by vger.kernel.org with ESMTP
	id S265988AbUAKVJG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 16:09:06 -0500
Subject: Re: 2.6.1: data corrupton when recieving files > 1GB over network
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: yoann <informatique@mistur.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4001BA10.5080803@mistur.org>
References: <5.1.0.14.2.20040111161640.014ad6c0@localhost>
	 <btsaum$g7f$1@sea.gmane.org>
	 <1073854512.4967.18.camel@nidelv.trondhjem.org>
	 <4001BA10.5080803@mistur.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1073855345.4963.21.camel@nidelv.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sun, 11 Jan 2004 16:09:06 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På su , 11/01/2004 klokka 16:03, skreiv yoann:
> > If the former, have you tried changing servers? (BTW: is this the kernel
> > server, or are you using the userland nfs-server daemon).
> 
> kernelland
> 
> I haven't try in userland

Try swapping the 2.4.18 kernel on mistur for something more recent.
AFAICS that server is the common element in your test.

Cheers,
  Trond
