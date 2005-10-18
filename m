Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751459AbVJRHrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751459AbVJRHrN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 03:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751461AbVJRHrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 03:47:13 -0400
Received: from ip-svs-1.Informatik.Uni-Oldenburg.DE ([134.106.12.126]:56756
	"EHLO aechz.svs.informatik.uni-oldenburg.de") by vger.kernel.org
	with ESMTP id S1751459AbVJRHrN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 03:47:13 -0400
Date: Tue, 18 Oct 2005 09:46:01 +0200
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Rob Landley <rob@landley.net>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Documentation for ramfs, rootfs, initramfs.
Message-ID: <20051018074601.GA2404@titan.lahn.de>
Mail-Followup-To: Rob Landley <rob@landley.net>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200510172242.08809.rob@landley.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510172242.08809.rob@landley.net>
Organization: UUCP-Freunde Lahn e.V.
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Non a native speaker myself, but if I remember correctly, I found the
following issues in your nice documentation, which you might want to fix:

On Mon, Oct 17, 2005 at 10:42:08PM -0500, Rob Landley wrote:
> --- old/Documentation/filesystems/ramfs-rootfs-initramfs.txt 2005-10-17 22:39:30.194448784 -0500
> +What is ramfs?
> +--------------

s/cacheing/caching/
s/soon soon/soon/
s/was of a fixed size/was of fixed size/
s/was a fixed size/was of fixed size/

> +What is initramfs?
> +------------------

s/bringing the system the rest of the way up/bringing the system up the rest of the way/
s/after the embedded cpio archive is extracted into it//
s/a root partition, then exec/a root partition and execute/

> +All this differs from the old initrd in several ways:

s/but by default it's an empty archive./but by default is an empty archive./
s/When switching another root device/When switching to another root device/

BYtE
Philipp
-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
