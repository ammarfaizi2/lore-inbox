Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262247AbVHCL6m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262247AbVHCL6m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 07:58:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbVHCL4U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 07:56:20 -0400
Received: from outmx004.isp.belgacom.be ([195.238.2.101]:8921 "EHLO
	outmx004.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S262253AbVHCLy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 07:54:57 -0400
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Date: Wed, 3 Aug 2005 13:54:52 +0200
User-Agent: KMail/1.8.1
Cc: Con Kolivas <kernel@kolivas.org>, ck@vds.kolivas.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com
References: <200508031559.24704.kernel@kolivas.org>
In-Reply-To: <200508031559.24704.kernel@kolivas.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508031354.52972.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 August 2005 07:59, Con Kolivas wrote:
> This is the dynamic ticks patch for i386 as written by Tony Lindgen
> <tony@atomide.com> and Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>.
> Patch for 2.6.13-rc5
>

Compiles and runs ok here.

Is there actually any timer frequency that's advisable to set as maximum? (in 
the kernel config)

Jan
-- 
To stand and be still,
At the Birkenhead drill,
Is a damned tough bullet to chew.
		-- Rudyard Kipling
