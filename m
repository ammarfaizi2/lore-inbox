Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262643AbUCEQmh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 11:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbUCEQmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 11:42:37 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:56581 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262643AbUCEQmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 11:42:35 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Pascal Schmidt <der.eremit@email.de>
Subject: Re: initrd does not boot in 2.6.3, working in 2.4.25
Date: Fri, 5 Mar 2004 18:27:21 +0200
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <1wle0-48P-31@gated-at.bofh.it> <E1AzEtm-00003y-Pi@localhost>
In-Reply-To: <E1AzEtm-00003y-Pi@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403051827.22057.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 March 2004 14:57, Pascal Schmidt wrote:
> On Fri, 05 Mar 2004 12:00:24 +0100, you wrote in linux.kernel:
> > linld image=3D263 initrd=3Dimage.gz vga=3D4 "cl=3Droot=3D/dev/ram
> > init=3D= /linuxrc.nfs.vda devfs=3Dmount"
>
> Try root=/dev/ram0

I tried. Not working.
--
vda

