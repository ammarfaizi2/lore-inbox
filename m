Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263442AbUDVFTb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263442AbUDVFTb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 01:19:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263544AbUDVFTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 01:19:31 -0400
Received: from diplo.antw.online.be ([62.112.0.10]:62170 "EHLO
	diplo.antw.online.be") by vger.kernel.org with ESMTP
	id S263442AbUDVFTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 01:19:30 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: System hang with ATI's lousy driver
Date: Thu, 22 Apr 2004 07:18:39 +0200
User-Agent: KMail/1.6.2
Cc: Joel Jaeggli <joelja@darkwing.uoregon.edu>,
       Timothy Miller <miller@techsource.com>
References: <Pine.LNX.4.44.0404201216280.10469-100000@twin.uoregon.edu>
In-Reply-To: <Pine.LNX.4.44.0404201216280.10469-100000@twin.uoregon.edu>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200404220718.40070.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 April 2004 21:28, Joel Jaeggli wrote:

> kernel drm + xfree86 driver will actually provide accelerated opengl
> support in Xwindows albiet without quite as many hardware features as the
> proprietary driver on all the rv2xx chipsets including the 9000 but not
> on the later models.
>
> kernel drm & radeonfb have been reported to not play very well with each
> other in other venues. vesafb is known to work in this situation though.

I have that particular setup running quite satisfactory now for a few months, 
using a Radeon 9000 Mobile chip. No problems at all.

Jan

-- 
Test-tube babies shouldn't throw stones.
