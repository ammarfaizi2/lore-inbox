Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbWCQRuA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbWCQRuA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Mar 2006 12:50:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbWCQRuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Mar 2006 12:50:00 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:38335 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030227AbWCQRuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Mar 2006 12:50:00 -0500
Date: Fri, 17 Mar 2006 09:49:50 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Benjamin Bach <benjamin@overtag.dk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Idea: Automatic binary driver compiling system
In-Reply-To: <441AF93C.6040407@overtag.dk>
Message-ID: <Pine.LNX.4.64.0603170949170.9513@schroedinger.engr.sgi.com>
References: <441AF93C.6040407@overtag.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Mar 2006, Benjamin Bach wrote:

> I would be very grateful for pointers to any helpful resource and also
> thoughts on what problems I'm facing. Also I'm aware that this is probably not
> the first time "batch module compiling" has been mentioned... ?

"make modules" build all modules. You can batch it with nohup?

