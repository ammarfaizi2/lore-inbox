Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbTENQgP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 12:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262473AbTENQgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 12:36:14 -0400
Received: from sb0-cf9a4970.dsl.impulse.net ([207.154.73.112]:2568 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S262206AbTENQgN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 12:36:13 -0400
Subject: Re: [PATCH] 2.5.69 Changes to Kconfig and i386 Makefile to include
	support for various K7 optimizations
From: Ray Lee <ray-lk@madrabbit.org>
To: thomas@horsten.com, davej@suse.de
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1052930982.12607.243.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 14 May 2003 09:49:42 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> On Wed, May 07, 2003 at 06:34:26PM +0100, Thomas Horsten wrote:
>> Please have a look, and pass me any comments.

> I don't think this is worth the extra complication. The potential wins
> (if any) outweigh the confusion to users who might have no clue as to 
> what core they have. 

How's about a "This CPU" option instead, a la gcccpuopt [1], that sets
the correct CPU options for the current machine/gcc combo?

[1] http://google.com/search?q=gcccpuopt

Ray

