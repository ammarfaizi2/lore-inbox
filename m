Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262508AbUDAQtp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 11:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262514AbUDAQto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 11:49:44 -0500
Received: from mail.shareable.org ([81.29.64.88]:15253 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262508AbUDAQtF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 11:49:05 -0500
Date: Thu, 1 Apr 2004 17:49:01 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Sergey Vlasov <vsu@altlinux.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 kernels misdetect harddisk geometry, 2.4 kernels are fine
Message-ID: <20040401164901.GE25502@mail.shareable.org>
References: <406C2AFB.1030101@gmx.net> <20040401192246.00719d71.vsu@altlinux.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040401192246.00719d71.vsu@altlinux.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Vlasov wrote:
> In fact, this did not work correctly even in 2.4, except in some very
> limited circumstances: either hda only, or hda+hdb.  Even hda+hdc
> configuration was broken (hda was getting parameters from BIOS, but
> hdc was not).

What do MS-DOS and Windows do in the hda+hdc case?

-- Jamie
