Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932157AbVHWVY5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932157AbVHWVY5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:24:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932199AbVHWVY5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:24:57 -0400
Received: from dspnet.fr.eu.org ([213.186.44.138]:13834 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932157AbVHWVY4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:24:56 -0400
Date: Tue, 23 Aug 2005 23:24:34 +0200
From: Olivier Galibert <galibert@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Initramfs and TMPFS!
Message-ID: <20050823212434.GA14482@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	linux-kernel@vger.kernel.org
References: <200508232116.j7NLG51g028312@ms-smtp-01.rdc-nyc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508232116.j7NLG51g028312@ms-smtp-01.rdc-nyc.rr.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 05:16:05PM -0400, robotti@godmail.com wrote:
> Why doesn't initramfs use tmpfs instead of ramfs, because
> tmpfs is more robust?
> 
> I know tmpfs is larger, but at least it should be an option.
> 
> Also, tar should be an option instead of cpio for the archiver,
> because tar is more widely used.

You forgot to attach your patch to your email.

  OG.
