Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263447AbTDGOGy (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 10:06:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263438AbTDGOGy (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 10:06:54 -0400
Received: from [80.190.48.67] ([80.190.48.67]:18700 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263447AbTDGOGy (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 10:06:54 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Interactivity backport to 2.4.20-ck*
Date: Mon, 7 Apr 2003 16:17:56 +0200
User-Agent: KMail/1.5.1
References: <200304072353.47664.kernel@kolivas.org>
In-Reply-To: <200304072353.47664.kernel@kolivas.org>
Cc: Con Kolivas <kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304071617.56106.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 April 2003 15:53, Con Kolivas wrote:

Hi Con,

> I've had numerous requests for a backport of the interactivity changes to
> the O(1) scheduler for the -ck* kernels. I have resisted posting my
> backport because people had described real problems with these patches.
> However it seems most, if not all of the problems are related to one patch.
> Get them here:
> http://kernel.kolivas.org
Why isn't this patch completely backed out from the main O(1) so we can see 
what is new?

ciao, Marc


