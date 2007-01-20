Return-Path: <linux-kernel-owner+w=401wt.eu-S965371AbXATU27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965371AbXATU27 (ORCPT <rfc822;w@1wt.eu>);
	Sat, 20 Jan 2007 15:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965369AbXATU27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Jan 2007 15:28:59 -0500
Received: from [139.30.44.16] ([139.30.44.16]:29752 "EHLO
	gockel.physik3.uni-rostock.de" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S965371AbXATU26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Jan 2007 15:28:58 -0500
Date: Sat, 20 Jan 2007 21:28:57 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Willy Tarreau <w@1wt.eu>
cc: Ismail =?iso-8859-1?Q?D=F6nmez?= <ismail@pardus.org.tr>,
       linux-kernel@vger.kernel.org
Subject: Re: Abysmal disk performance, how to debug?
In-Reply-To: <20070120201923.GC25307@1wt.eu>
Message-ID: <Pine.LNX.4.63.0701202124180.23674@gockel.physik3.uni-rostock.de>
References: <200701201920.54620.ismail@pardus.org.tr> <200701201952.54714.ismail@pardus.org.tr>
 <Pine.LNX.4.63.0701202105210.23674@gockel.physik3.uni-rostock.de>
 <200701202216.16637.ismail@pardus.org.tr> <20070120201923.GC25307@1wt.eu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Jan 2007, Willy Tarreau wrote:

> Anyway, in your situation with a very small buffer, this should not 
> change by more than half a second or so.

Well, his buffer is not small. He has half a GB of RAM, so when 
writing 1 GB the buffer would roughly double the dd speed, exactly as he 
has shown us.

Anyways, instead of always just posting similar answers to yours, I'll 
have dinner now. :-)

Tim
