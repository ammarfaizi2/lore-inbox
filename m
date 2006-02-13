Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWBMLK3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWBMLK3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 06:10:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751747AbWBMLK3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 06:10:29 -0500
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:15886 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1751253AbWBMLK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 06:10:28 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: 2.6.16, sk98lin out of date
Date: Mon, 13 Feb 2006 11:10:34 +0000
User-Agent: KMail/1.9.1
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <200602131058.03419.s0348365@sms.ed.ac.uk> <20060213110542.GZ3927@mea-ext.zmailer.org>
In-Reply-To: <20060213110542.GZ3927@mea-ext.zmailer.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602131110.34212.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 13 February 2006 11:05, Matti Aarnio wrote:
> On Mon, Feb 13, 2006 at 10:58:03AM +0000, Alistair John Strachan wrote:
> > Hi,
> >
> > As I'm sure the drivers/net maintainers are well aware, SysKonnect
> > constantly update their sk98lin/sky2 driver without bothering to sync
> > their changes with the official linux kernel.
>
> My understanding is, that  skge  driver has superceded the  sk98lin  in
> most uses.
>
> There could, of course, be a change to insert vendor driver _as_is_ into
> baseline kernel with its own name.

Thanks Matti, I wasn't even aware of this driver. Might I suggest the "old" 
driver be marked as such in Linux 2.6.16. I guess I must've skipped over it 
because it begins with "New", and does not contain the word "Marvell", which 
is indicated exclusively by lspci.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
