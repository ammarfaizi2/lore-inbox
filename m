Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261444AbVCRDPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261444AbVCRDPo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Mar 2005 22:15:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261445AbVCRDPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Mar 2005 22:15:44 -0500
Received: from gate.crashing.org ([63.228.1.57]:61897 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261444AbVCRDPl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Mar 2005 22:15:41 -0500
Subject: Re: [PATCH] Prezeroing V8
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christoph Lameter <clameter@sgi.com>
Cc: Nish Aravamudan <nish.aravamudan@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0503171505260.10205@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0503171340480.9678@schroedinger.engr.sgi.com>
	 <29495f1d05031714596de3b335@mail.gmail.com>
	 <Pine.LNX.4.58.0503171505260.10205@schroedinger.engr.sgi.com>
Content-Type: text/plain
Date: Fri, 18 Mar 2005 14:14:53 +1100
Message-Id: <1111115694.3835.85.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-03-17 at 15:06 -0800, Christoph Lameter wrote:

> I want to sleep 30 seconds because the system load is unlikely to change
> frequently.

Ugh ? That sounds like a magic number coming right from your hat or from
your test scenario ...

Ben.

