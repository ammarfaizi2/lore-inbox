Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261300AbUCQKU2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 05:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbUCQKU1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 05:20:27 -0500
Received: from lindsey.linux-systeme.com ([62.241.33.80]:46089 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S261300AbUCQKUU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 05:20:20 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: vmware on linux 2.6.4
Date: Wed, 17 Mar 2004 11:19:48 +0100
User-Agent: KMail/1.6.1
Cc: mru@kth.se (=?iso-8859-15?q?M=E5ns?= =?iso-8859-15?q?_Rullg=E5rd?=)
References: <yw1xu10ogy4m.fsf@kth.se>
In-Reply-To: <yw1xu10ogy4m.fsf@kth.se>
X-Operating-System: Linux 2.6.4-wolk2.1 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200403171119.48026@WOLK>
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 17 March 2004 00:39, Måns Rullgård wrote:

Hi Mans,

> I tried to build the vmware modules for kernel 2.6.4 and got this oops
> when loading vmmon.o:
> vmmon: no version magic, tainting kernel.
> vmmon: module license 'unspecified' taints kernel.
> Unable to handle kernel NULL pointer dereference at virtual address
> Suggestions welcome.

what vmware version do you use? Please make sure you've updated to latest 
any-any update from (1.)


1.) ftp://platan.vc.cvut.cz/pub/vmware

ciao, Marc
