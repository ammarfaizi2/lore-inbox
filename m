Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263215AbTB0KfY>; Thu, 27 Feb 2003 05:35:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263342AbTB0KfY>; Thu, 27 Feb 2003 05:35:24 -0500
Received: from griffon.mipsys.com ([217.167.51.129]:14810 "EHLO
	zion.wanadoo.fr") by vger.kernel.org with ESMTP id <S263215AbTB0KfX>;
	Thu, 27 Feb 2003 05:35:23 -0500
Subject: Re: Linux 2.4.21-pre5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Simon Oosthoek <simon@cal003100.student.utwente.nl>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030227101912.GA4006@margo.student.utwente.nl>
References: <Pine.LNX.4.53L.0302270314050.1433@freak.distro.conectiva>
	 <3E5DDCE7.2040100@linux.org.hk>
	 <20030227101912.GA4006@margo.student.utwente.nl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1046342924.27186.249.camel@zion.wanadoo.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 27 Feb 2003 11:48:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-02-27 at 11:19, Simon Oosthoek wrote:

> here's a patch that should work to fix this.

I think the proper fix for now is to bring back all of
ieee1394 from pre4 to pre5, it was an incorrect merge
that reverted part of it.

Ben.

