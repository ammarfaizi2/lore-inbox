Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265515AbUASRce (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 12:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265501AbUASRce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 12:32:34 -0500
Received: from pizda.ninka.net ([216.101.162.242]:23441 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S265515AbUASRcd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 12:32:33 -0500
Date: Mon, 19 Jan 2004 09:24:35 -0800
From: "David S. Miller" <davem@redhat.com>
To: Robert Olsson <Robert.Olsson@data.slu.se>
Cc: joern@wohnheim.fh-wedel.de, buytenh@gnu.org, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: [PATCH] Re: [2.6.0, pktgen] divide-by-zero
Message-Id: <20040119092435.25536daa.davem@redhat.com>
In-Reply-To: <16395.5021.616055.384516@robur.slu.se>
References: <20031231111316.GA10218@gnu.org>
	<20040118154802.GE10397@wohnheim.fh-wedel.de>
	<16395.5021.616055.384516@robur.slu.se>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Jan 2004 00:15:41 +0100
Robert Olsson <Robert.Olsson@data.slu.se> wrote:

>  I suggest the patch below to get integer precision at very short time 
>  intervals too.

Applied, thanks Robert.
