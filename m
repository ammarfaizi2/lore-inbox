Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263504AbTKTX0P (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 18:26:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263119AbTKTX0P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 18:26:15 -0500
Received: from mail.jlokier.co.uk ([81.29.64.88]:43447 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S263895AbTKTXZe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 18:25:34 -0500
Date: Thu, 20 Nov 2003 23:25:32 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: transmeta cpu code question
Message-ID: <20031120232532.GA8229@mail.shareable.org>
References: <20031120020218.GJ3748@schottelius.org> <200311201210.04780.ben@jeeves.bpa.nu> <20031120083827.GL3748@schottelius.org> <bpitsu$732$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bpitsu$732$1@cesium.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> It's also not faster in any meaningful way, since the dynamic
> translator does optimistic optimization.

Statically compiled code for the Crusoe chips may not be faster.
(Arguably statically compiled code for _any_ CPU is not the best
strategy for fast code).

But if someone is able to write better code morphing software than
Transmeta, that would be faster :)

-- Jamie
