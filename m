Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267324AbUGNPpj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267324AbUGNPpj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 11:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267329AbUGNPpi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 11:45:38 -0400
Received: from slartibartfast.pa.net ([66.59.111.182]:65481 "EHLO
	slartibartfast.pa.net") by vger.kernel.org with ESMTP
	id S267324AbUGNPpK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 11:45:10 -0400
Date: Wed, 14 Jul 2004 11:42:51 -0400 (EDT)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: wstearns@sparrow
Reply-To: William Stearns <wstearns@pobox.com>
To: Michael Buesch <mbuesch@freenet.de>
cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       William Stearns <wstearns@pobox.com>
Subject: Re: [Q] don't allow tmpfs to page out
In-Reply-To: <200407141654.31817.mbuesch@freenet.de>
Message-ID: <Pine.LNX.4.58.0407141141350.6240@sparrow>
References: <200407141654.31817.mbuesch@freenet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good afternoon, Michael,

On Wed, 14 Jul 2004, Michael Buesch wrote:

> Is it possible to disable the tmpfs feature to page out
> memory to swap?
> I didn't find any mount option or something like that
> for it in the documentation.

	I suspect a regular ramdisk, as opposed to tmpfs, would do what 
you want.
	Cheers,
	- Bill

---------------------------------------------------------------------------
	"Heisenberg _may_ have slept here."
(Courtesy of Rick Stevens <rstevens@vitalstream.com>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
--------------------------------------------------------------------------
