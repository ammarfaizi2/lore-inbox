Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbVDXAPh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVDXAPh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 20:15:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262197AbVDXAPg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 20:15:36 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18904 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262195AbVDXAPd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 20:15:33 -0400
Date: Sat, 23 Apr 2005 20:14:30 -0400
From: Alan Cox <alan@redhat.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org, James.Bottomley@SteelEye.co,
       linux-scsi@vger.kernel.org
Subject: Re: [2.6 patch] drivers/scsi/atp870u.c: make a function static
Message-ID: <20050424001430.GB1236@devserv.devel.redhat.com>
References: <20050423220817.GF4355@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050423220817.GF4355@stusta.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2005 at 12:08:18AM +0200, Adrian Bunk wrote:
> This patch makes a needlessly global function static.

ACK

> 
