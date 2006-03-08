Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751207AbWCHHKg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbWCHHKg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 02:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752022AbWCHHKg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 02:10:36 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:27809 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751207AbWCHHKf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 02:10:35 -0500
Date: Wed, 8 Mar 2006 09:10:33 +0200 (EET)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Jack Steiner <steiner@sgi.com>
cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] - Allocate larger cache_cache if order 0 fails
In-Reply-To: <20060307205801.GA12136@sgi.com>
Message-ID: <Pine.LNX.4.58.0603080910150.20654@sbz-30.cs.Helsinki.FI>
References: <20060307154805.GA3474@sgi.com> <84144f020603071136m21782038n8951c801627ae867@mail.gmail.com>
 <20060307205801.GA12136@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Mar 2006, Jack Steiner wrote:
> Does anyone see a compelling reason for a different but equivalent implementation??

Less duplicate code?

			Pekka
