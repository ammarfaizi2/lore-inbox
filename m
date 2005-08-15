Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965000AbVHOW02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbVHOW02 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 18:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbVHOW02
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 18:26:28 -0400
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:18622 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S965000AbVHOW01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 18:26:27 -0400
Date: Tue, 16 Aug 2005 00:26:24 +0200
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: Naveen Gupta <ngupta@google.com>
Cc: wim@iguana.be, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [-mm PATCH] set correct bit in reload register of Watchdog Timer for Intel 6300 chipset
Message-ID: <20050815222623.GA18872@hardeman.nu>
References: <Pine.LNX.4.56.0508151359410.26489@krishna.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.56.0508151359410.26489@krishna.corp.google.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2005 at 02:02:19PM -0700, Naveen Gupta wrote:
>
>This patch writes into bit 8 of the reload register to perform the
>correct 'Reload Sequence' instead of writing into bit 4 of Watchdog for
>Intel 6300ESB chipset.
>
>Signed-off-by: Naveen Gupta <ngupta@google.com>

Acked-by: David Härdeman <david@2gen.com>

Thanks alot Naveen.

//David
