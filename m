Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265224AbUFHP5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265224AbUFHP5p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jun 2004 11:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265241AbUFHP5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jun 2004 11:57:45 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:58496 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S265224AbUFHP5o convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jun 2004 11:57:44 -0400
Subject: Re: NFS corruption (duplicated data)
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Andy <genanr@emsphone.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040608154422.GA3946@thumper2>
References: <20040608154422.GA3946@thumper2>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1086710260.3896.9.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 08 Jun 2004 11:57:43 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På ty , 08/06/2004 klokka 11:44, skreiv Andy:
> I really don't understand what could be causing this, but it happens on
> several machine and at least on kernels 2.4.22, 2.4.25, 2.4.26.
> NFS v3 : hard, udp, rsize=8192,wsize=8192
> local filesystems are XFS

Does it occur on non-XFS partitions?

Cheers,
  Trond
