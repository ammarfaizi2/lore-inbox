Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261934AbTCHAEt>; Fri, 7 Mar 2003 19:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261966AbTCHAEt>; Fri, 7 Mar 2003 19:04:49 -0500
Received: from pa91.banino.sdi.tpnet.pl ([213.76.211.91]:13323 "EHLO
	alf.amelek.gda.pl") by vger.kernel.org with ESMTP
	id <S261934AbTCHAEr>; Fri, 7 Mar 2003 19:04:47 -0500
Date: Sat, 8 Mar 2003 01:15:17 +0100
To: Ed Vance <EdV@macrolink.com>
Cc: "'Bryan Whitehead'" <driver@jpl.nasa.gov>, linux-kernel@vger.kernel.org,
       linux-newbie@vger.kernel.org
Subject: Re: devfs + PCI serial card = no extra serial ports
Message-ID: <20030308001517.GB20120@alf.amelek.gda.pl>
References: <11E89240C407D311958800A0C9ACF7D1A33DD4@EXCHANGE>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11E89240C407D311958800A0C9ACF7D1A33DD4@EXCHANGE>
User-Agent: Mutt/1.4i
From: Marek Michalkiewicz <marekm@amelek.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 07, 2003 at 03:40:31PM -0800, Ed Vance wrote:
> Sure, go ahead and try the second patch that adds the Netmos cards to the
> serial driver's device tables. It is for a somewhat newer rev, but you might
> just get offsets with no failed hunks. It's worth a try.

Note that the second patch depends on the first one (link order fix),
so please apply both patches in the order listed.

After 2.4.21 is released, I'll try to remember to update the patches.

Marek

