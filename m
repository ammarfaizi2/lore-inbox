Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262810AbUEFPtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbUEFPtQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 11:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbUEFPtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 11:49:16 -0400
Received: from stingr.net ([212.193.32.15]:12442 "EHLO stingr.net")
	by vger.kernel.org with ESMTP id S262768AbUEFPs0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 11:48:26 -0400
Date: Thu, 6 May 2004 19:48:24 +0400
From: Paul P Komkoff Jr <i@stingr.net>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH-RFC] code for raceless /sys/fs/foofs/*
Message-ID: <20040506154824.GH13255@stingr.net>
Mail-Followup-To: linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <16536.61900.721224.492325@laputa.namesys.com> <20040505162802.GN17014@parcelfarce.linux.theplanet.co.uk> <20040505163650.GO17014@parcelfarce.linux.theplanet.co.uk> <1083776930.3622.45.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <1083776930.3622.45.camel@lade.trondhjem.org>
User-Agent: Agent Darien Fawkes
X-Mailer: Intel Ultra ATA Storage Driver
X-RealName: Stingray Greatest Jr
Organization: Department of Fish & Wildlife
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Replying to Trond Myklebust:
> ...and if you do, aren't you more likely to simply 'mount --bind' those
> minimal parts of sysfs that you actually need for the given process that
> is gaoled?

selinux comes on my mind ...

-- 
Paul P 'Stingray' Komkoff Jr // http://stingr.net/key <- my pgp key
 This message represents the official view of the voices in my head
