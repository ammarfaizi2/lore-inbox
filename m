Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262006AbTDAEQR>; Mon, 31 Mar 2003 23:16:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262045AbTDAEQR>; Mon, 31 Mar 2003 23:16:17 -0500
Received: from havoc.daloft.com ([64.213.145.173]:1924 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S262006AbTDAEQQ>;
	Mon, 31 Mar 2003 23:16:16 -0500
Date: Mon, 31 Mar 2003 23:27:34 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Brad Campbell <brad@seme.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: via-rhine problem on EPIAV-1Ghz 2.4.21-pre6
Message-ID: <20030401042734.GA21273@gtf.org>
References: <3E88FA24.7040406@seme.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E88FA24.7040406@seme.com.au>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 01, 2003 at 10:32:04AM +0800, Brad Campbell wrote:
> G'day all,
> I have a problem with the via-rhine on this board timing out.

Try booting with "noapic"

I have sent via-rhine fixes to Marcelo, hopefully they will appear in -pre7

	Jeff



