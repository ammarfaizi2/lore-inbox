Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265510AbUBPNNX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 08:13:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265514AbUBPNNX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 08:13:23 -0500
Received: from intra.cyclades.com ([64.186.161.6]:65511 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265510AbUBPNMr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 08:12:47 -0500
Date: Mon, 16 Feb 2004 10:10:51 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Philippe Elie <phil.el@wanadoo.fr>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       John Levon <levon@movementarian.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.25-rc2 export smp_num_siblings cpu_sibling_map
In-Reply-To: <20040214014745.GA470@zaniah>
Message-ID: <Pine.LNX.4.58L.0402161010230.4334@logos.cnet>
References: <20040214014745.GA470@zaniah>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 14 Feb 2004, Philippe Elie wrote:

> Hi,
>
> With 2.4 oprofile is built as an out of tree driver. I backported P4 HT
> support from 2.6 to our driver but it needs these two export to work.
>
> Any problem to apply this for 2.4.25 (or later if it's too late for .25) ?

Queued for 2.4.26pre
