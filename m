Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261253AbVAXMba@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVAXMba (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 07:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261391AbVAXMb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 07:31:29 -0500
Received: from mx1.redhat.com ([66.187.233.31]:5062 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261253AbVAXMb1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 07:31:27 -0500
Date: Mon, 24 Jan 2005 07:31:20 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Fruhwirth Clemens <clemens-dated-1107431785.31e3@endorphin.org>
cc: akpm@osdl.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/04] Adding cipher mode context information to crypto_tfm
In-Reply-To: <20050124115624.GA21457@ghanima.endorphin.org>
Message-ID: <Xine.LNX.4.44.0501240728240.21040-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll review this in detail over the next day or so (still catching up on 
some backlog after vacation).

Just wondering how much testing the generic scatterwalk code has had (I 
gather disk encryption has been tested, but what about ipsec?).


- James
-- 
James Morris
<jmorris@redhat.com>



