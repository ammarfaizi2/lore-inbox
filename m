Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbUCJKGO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 05:06:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbUCJKGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 05:06:14 -0500
Received: from moutng.kundenserver.de ([212.227.126.184]:30447 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262560AbUCJKGN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 05:06:13 -0500
From: Markus Klotzbuecher <mk@creamnet.de>
Reply-To: mk@creamnet.de
To: Romain Lievin <romain@lievin.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Question: user-land filesystem & vfs
Date: Wed, 10 Mar 2004 11:11:00 +0100
User-Agent: KMail/1.5.4
References: <20040310095147.GA18197@lievin.net>
In-Reply-To: <20040310095147.GA18197@lievin.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403101111.00977.mk@creamnet.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:89d1891c7eff3dde0c02a5f1254dd9ac
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 March 2004 10:51, Romain Lievin wrote:
> Hi,
>
> is there a way to create a file system in user mode (without patching the
> kernel) ?

You might want to take a look at PerlFs, that allows you to write a filesystem 
in Perl: 

http://perlfs.sourceforge.net/

Cheers

Markus

