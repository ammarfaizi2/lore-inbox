Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262585AbUCEM6K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 07:58:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbUCEM6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 07:58:10 -0500
Received: from mail4-141.ewetel.de ([212.6.122.141]:5783 "EHLO mail4.ewetel.de")
	by vger.kernel.org with ESMTP id S262585AbUCEM6I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 07:58:08 -0500
To: vda <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: initrd does not boot in 2.6.3, working in 2.4.25
In-Reply-To: <1wle0-48P-31@gated-at.bofh.it>
References: <1wle0-48P-31@gated-at.bofh.it>
Date: Fri, 5 Mar 2004 13:57:54 +0100
Message-Id: <E1AzEtm-00003y-Pi@localhost>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 05 Mar 2004 12:00:24 +0100, you wrote in linux.kernel:

> linld image=3D263 initrd=3Dimage.gz vga=3D4 "cl=3Droot=3D/dev/ram init=3D=
> /linuxrc.nfs.vda devfs=3Dmount"

Try root=/dev/ram0

-- 
Ciao,
Pascal
