Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261720AbVGTAYX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261720AbVGTAYX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 20:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261726AbVGTAYW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 20:24:22 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:26618 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261720AbVGTAYG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 20:24:06 -0400
Subject: Re: Interbench real time benchmark results
From: Daniel Walker <dwalker@mvista.com>
Reply-To: dwalker@mvista.com
To: Ingo Molnar <mingo@elte.hu>
Cc: Con Kolivas <kernel@kolivas.org>, linux-kernel@vger.kernel.org,
       ck@vds.kolivas.org
In-Reply-To: <20050719223216.GA4194@elte.hu>
References: <200507200816.11386.kernel@kolivas.org>
	 <20050719223216.GA4194@elte.hu>
Content-Type: text/plain
Organization: MontaVista
Date: Tue, 19 Jul 2005 17:23:57 -0700
Message-Id: <1121819037.26927.75.camel@dhcp153.mvista.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-07-20 at 00:32 +0200, Ingo Molnar wrote:

> 
>  - networking is another frequent source of latencies - it might make 
>    sense to add a workload doing lots of socket IO. (localhost might be 
>    enough, but not for everything)

The Gnutella test?

Daniel

