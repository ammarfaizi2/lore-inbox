Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbTLPTb2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 14:31:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262153AbTLPTb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 14:31:28 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:50130 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262131AbTLPTb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 14:31:27 -0500
Subject: Re: Double Interrupt with HT
From: john stultz <johnstul@us.ibm.com>
To: Miroslaw KLABA <totoro@totoro.be>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20031215155843.210107b6.totoro@totoro.be>
References: <20031215155843.210107b6.totoro@totoro.be>
Content-Type: text/plain
Organization: 
Message-Id: <1071603069.991.194.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 16 Dec 2003 11:31:10 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-15 at 06:58, Miroslaw KLABA wrote:
> I've got a problem while using Hyper-Threading on a motherboard with Via P4M266A
> chipset with 2.4.23 kernel.

Could you try to narrow down when the problem first appeared? Was it not
seen in 2.4.23-pre3 but showed up in 2.4.23-rc1? The narrower the
better. 

thanks
-john



