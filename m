Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbUCIJ42 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 04:56:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261853AbUCIJ42
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 04:56:28 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:19469 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261851AbUCIJ4X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 04:56:23 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: mru@kth.se (=?iso-8859-1?q?M=E5ns?= =?iso-8859-1?q?=20Rullg=E5rd?=),
       linux-kernel@vger.kernel.org
Subject: Re: GPLv2 or not GPLv2? (no license bashing)
Date: Tue, 9 Mar 2004 11:53:23 +0200
X-Mailer: KMail [version 1.4]
References: <200403040838.31412.eike-kernel@sf-tec.de> <200403090916.08626.vda@port.imtp.ilyichevsk.odessa.ua> <yw1xhdwy8k8c.fsf@kth.se>
In-Reply-To: <yw1xhdwy8k8c.fsf@kth.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200403091153.23593.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 March 2004 11:04, Måns Rullgård wrote:
> vda <vda@port.imtp.ilyichevsk.odessa.ua> writes:
> > Well, Linux kernel is GPLed. If one adds his/hers code to the kernel
> > (s)he is automatically agrees to the terms of GPL.
> >
> > Because "adds code" is actually incorrect here.  "modifies existing
> > GPLed code" is more accurate.
>
> Suppose I write a new kernel module, without touching any existing
> code, and this module gets included in the kernel tree.  Have I added
> code?  Yes.  Have I modified GPLed code?  I think not.

I believe Linus said so too wrt out-of-tree modules.

I think modules included in 'official' tree better be GPLed
or else phrase 'Linux kernel is GPLed' becomes meaningless.
-- 
vda
