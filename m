Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265457AbTLSEuQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 23:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265458AbTLSEuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 23:50:16 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:29825 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S265457AbTLSEuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 23:50:14 -0500
Date: Thu, 18 Dec 2003 20:42:41 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: hanasaki <hanasaki@hanaden.com>
Cc: Linux - LIST <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.60-test11 - NFS server oddness
Message-ID: <20031219044241.GI6438@matchmail.com>
Mail-Followup-To: hanasaki <hanasaki@hanaden.com>,
	Linux - LIST <linux-kernel@vger.kernel.org>
References: <3FCEBF85.3040602@hanaden.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3FCEBF85.3040602@hanaden.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 03, 2003 at 11:00:53PM -0600, hanasaki wrote:
> nfs v3 on TCP
> Kernel 2.4.23
> 
> = File Server =
> nfs v3 on TCP
> kernell 2.6 test11
> 
> = NFS = All NFS is v3 on TCP

Can you try NFS on udp?
