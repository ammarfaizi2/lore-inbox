Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279054AbRJaBhA>; Tue, 30 Oct 2001 20:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279105AbRJaBgu>; Tue, 30 Oct 2001 20:36:50 -0500
Received: from CompactServ-SUrNet.ll.surnet.ru ([195.54.9.58]:3057 "EHLO
	zzz.zzz") by vger.kernel.org with ESMTP id <S279054AbRJaBgf>;
	Tue, 30 Oct 2001 20:36:35 -0500
Date: Wed, 31 Oct 2001 06:36:10 +0500
From: Denis Zaitsev <zzz@cd-club.ru>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] init/main.c/root_dev_names - another one #ifdef
Message-ID: <20011031063610.B22507@zzz.zzz.zzz>
In-Reply-To: <20011031045353.A22507@zzz.zzz.zzz> <E15yj2E-0001o7-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15yj2E-0001o7-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Oct 31, 2001 at 12:15:10AM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 31, 2001 at 12:15:10AM +0000, Alan Cox wrote:
> Secondly if you have an initrd containing the scsi driver layers then you
> can specify root=sda quite legitimately.

This sounds strange, as I don't mean the SCSI compiled-into-bzImage,
but the SCSI support at all.
