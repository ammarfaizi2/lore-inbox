Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750922AbVJLAYu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922AbVJLAYu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 20:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751208AbVJLAYu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 20:24:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:22160 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751036AbVJLAYt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 20:24:49 -0400
Subject: Re: [PATCH] ppc64: Thermal control for SMU based machines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org
In-Reply-To: <20051011170358.2684347a.akpm@osdl.org>
References: <1128404215.31063.32.camel@gaston>
	 <20051011170358.2684347a.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 12 Oct 2005 10:20:36 +1000
Message-Id: <1129076436.17365.243.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-10-11 at 17:03 -0700, Andrew Morton wrote:

> This will leave wf_lock held on error.

Oops. Will fix along with the other ones you spotted asap.

Ben.


