Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbUCQQ6b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 11:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261496AbUCQQ6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 11:58:31 -0500
Received: from dh132.citi.umich.edu ([141.211.133.132]:34688 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S261439AbUCQQ62 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 11:58:28 -0500
Subject: Re: Linux 2.4.25, nfs client hangs when talking to a MacOS nfs
	server.
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Charles-Edouard Ruault <ce@idtect.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <117F2C39-7800-11D8-93C6-000A95CFFC9C@idtect.com>
References: <117F2C39-7800-11D8-93C6-000A95CFFC9C@idtect.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1079542707.3047.12.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 17 Mar 2004 11:58:27 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På on , 17/03/2004 klokka 05:44, skreiv Charles-Edouard Ruault:

> Does anyone have an idea of what's happening ? Is is a problem specific  
> to interactions between Linux & MacOS ? I could not find any info about  
> this on the net.
> Thanks in advance for any help.

Your Mac server is replying slooooooooowwwwwwwwllllllllllyyyyyyyyyyy.
That either indicates that you have a dirty network which is losing
packets (can happen if you are mixing 10Mbps and 100Mbps segments) or
the Mac server is hanging.

Cheers,
  Trond
