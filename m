Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263637AbUCYXHv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 18:07:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263680AbUCYW5O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 17:57:14 -0500
Received: from 1-2-2-1a.has.sth.bostream.se ([82.182.130.86]:44706 "EHLO
	K-7.stesmi.com") by vger.kernel.org with ESMTP id S263637AbUCYWzr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:55:47 -0500
Message-ID: <40636302.6080807@stesmi.com>
Date: Thu, 25 Mar 2004 23:53:54 +0100
From: Stefan Smietanowski <stesmi@stesmi.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7b) Gecko/20040316
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Adrian Bunk <bunk@fs.tum.de>, 239952@bugs.debian.org,
       debian-devel@lists.debian.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: Binary-only firmware covered by the GPL?
References: <E1B6Izr-0002Ai-00@r063144.stusta.swh.mhn.de> <20040325082949.GA3376@gondor.apana.org.au> <20040325220803.GZ16746@fs.tum.de> <40635DD9.8090809@pobox.com>
In-Reply-To: <40635DD9.8090809@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:

> 
> Well IANAL, but it seems not so cut-n-dried, at least.
> 
> Firmware is a program that executes on another processor, so no linking 
> is taking place at all.  It is analagous to shipping a binary-only 
> program in your initrd, IMO.

Except the firmware itself is GPL in this case.

// Stefan
