Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265085AbUEYTrZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265085AbUEYTrZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 15:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265082AbUEYTrY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 15:47:24 -0400
Received: from chaos.analogic.com ([204.178.40.224]:7040 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S265080AbUEYTol
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 15:44:41 -0400
Date: Tue, 25 May 2004 15:44:37 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Olaf Hering <olh@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: very low performance on SCSI disks if device node is in tmpfs
In-Reply-To: <20040525193458.GA21120@suse.de>
Message-ID: <Pine.LNX.4.53.0405251540410.803@chaos>
References: <20040525184732.GB26661@suse.de> <Pine.LNX.4.53.0405251457450.582@chaos>
 <20040525193458.GA21120@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 May 2004, Olaf Hering wrote:

>  On Tue, May 25, Richard B. Johnson wrote unrelated stuff:
>

It is not unrelated stuff. If you think it is, you will
come to an incorrect conclusion with your experiments.
As I stated, you are not actually communicating with a
device-file except for the initial open().

> did you actually try it?
>
[SNIPPED... unrelated access time information]

Cheers,
Dick Johnson
Penguin : Linux version 2.4.26 on an i686 machine (5570.56 BogoMips).
            Note 96.31% of all statistics are fiction.


