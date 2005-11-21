Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbVKUQ2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbVKUQ2g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 11:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932385AbVKUQ2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 11:28:36 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:1194 "EHLO
	grelber.thyrsus.com") by vger.kernel.org with ESMTP id S932384AbVKUQ2f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 11:28:35 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Xose Vazquez Perez <xose.vazquez@gmail.com>
Subject: Re: [RFC] Documentation dir is a mess
Date: Mon, 21 Nov 2005 10:28:28 -0600
User-Agent: KMail/1.8
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org
References: <438069BD.6000401@gmail.com>
In-Reply-To: <438069BD.6000401@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511211028.28944.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 20 November 2005 06:19, Xose Vazquez Perez wrote:
> hi,
>
> _today_ Documentation/* is a mess of files. It would be good
> to have the _same_ tree as the code has:
>
> Documentation/
> Documentation/arch/
> Documentation/arch/i386/
> [...]
> Documentation/drivers/
> Documentation/drivers/net/
> Documentation/drivers/scsi/
> [...]
> Documentation/net
> [...]

Perhaps you're looking for "make htmldocs"?

Where would you put Documentation/unicode.txt in your proposed layout?  Or 
Documentation/filesystems/proc.txt?

Rob
