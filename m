Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263697AbUCYWee (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Mar 2004 17:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263677AbUCYWcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Mar 2004 17:32:41 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54478 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263682AbUCYWcJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Mar 2004 17:32:09 -0500
Message-ID: <40635DD9.8090809@pobox.com>
Date: Thu, 25 Mar 2004 17:31:53 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@fs.tum.de>
CC: 239952@bugs.debian.org, debian-devel@lists.debian.org,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Binary-only firmware covered by the GPL?
References: <E1B6Izr-0002Ai-00@r063144.stusta.swh.mhn.de> <20040325082949.GA3376@gondor.apana.org.au> <20040325220803.GZ16746@fs.tum.de>
In-Reply-To: <20040325220803.GZ16746@fs.tum.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Well IANAL, but it seems not so cut-n-dried, at least.

Firmware is a program that executes on another processor, so no linking 
is taking place at all.  It is analagous to shipping a binary-only 
program in your initrd, IMO.



