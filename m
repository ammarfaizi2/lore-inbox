Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263544AbTLSQsp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Dec 2003 11:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263573AbTLSQsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Dec 2003 11:48:45 -0500
Received: from sb0-cf9a48a7.dsl.impulse.net ([207.154.72.167]:60059 "EHLO
	madrabbit.org") by vger.kernel.org with ESMTP id S263544AbTLSQso
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Dec 2003 11:48:44 -0500
Subject: Re: 2.6.0 fails to complete boot - Sony VAIO laptop
From: Ray Lee <ray-lk@madrabbit.org>
To: Alexander Poquet <atp@csbd.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20031219093021.50D9E1E030CA3@csbd.org>
References: <20031219093021.50D9E1E030CA3@csbd.org>
Content-Type: text/plain
Message-Id: <1071852522.982.31.camel@orca.madrabbit.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 19 Dec 2003 08:48:43 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-12-18 at 17:30, Alexander Poquet wrote:
> Initially, it appeared to not get passed the Loading Linux.... phase; the screen
> would simply blank.
[...]
> .config follows
> CONFIG_ACPI=y
> CONFIG_APM=y

If you have time to experiment, try turning off ACPI and see if that
helps.

Ray Lee

