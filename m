Return-Path: <linux-kernel-owner+w=401wt.eu-S932726AbXAJHMH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932726AbXAJHMH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 10 Jan 2007 02:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932723AbXAJHMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Jan 2007 02:12:06 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:37391 "EHLO
	mail.cs.helsinki.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932726AbXAJHMG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Jan 2007 02:12:06 -0500
References: <Pine.LNX.4.64.0701091539160.10824@sbz-30.cs.Helsinki.FI>
            <Pine.LNX.4.64.0701091017350.15631@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0701091017350.15631@schroedinger.engr.sgi.com>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: Christoph Lameter <clameter@sgi.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, hugh@veritas.com
Subject: Re: slab: cache_grow cleanup
Date: Wed, 10 Jan 2007 09:12:04 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.45A491C4.00004914@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter writes:
> I am loosing track of these. What is the difference to earlier versions?

Nothing but a rediff on top of Linus' tree as Hugh's fix already went in. 

                Pekka 
