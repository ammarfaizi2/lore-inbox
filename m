Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbWCADCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbWCADCm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 22:02:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932505AbWCADCm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 22:02:42 -0500
Received: from ms-smtp-04-smtplb.tampabay.rr.com ([65.32.5.134]:42420 "EHLO
	ms-smtp-04.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S932504AbWCADCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 22:02:42 -0500
Message-ID: <44050EC0.8070602@cfl.rr.com>
Date: Tue, 28 Feb 2006 22:02:24 -0500
From: Phillip Susi <psusi@cfl.rr.com>
User-Agent: Mail/News 1.5 (X11/20060213)
MIME-Version: 1.0
To: Kamran Karimi <kamrankarimi@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: why VM_SHM has been removed from mm.h?
References: <BAY104-F11448E157F2C47E004A12DC0F70@phx.gbl>
In-Reply-To: <BAY104-F11448E157F2C47E004A12DC0F70@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a reason that you posted this as a reply to the "o_sync in 
vfat" thread?

Kamran Karimi wrote:
> Hello all,
> 
> VM_SHM is used by DIPC to quickly recognise when we are dealing with a 
> System V IPC segment. It has been "removed" from recent kernels (set to 
> 0). Is there an easy way to find out if a segment is a Sys V shm? if 
> not, I suggest we re-activate it.
> 
> -Kamran
> 

