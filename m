Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266901AbUGLRej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266901AbUGLRej (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 13:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266902AbUGLRej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 13:34:39 -0400
Received: from 209-128-98-078.bayarea.net ([209.128.98.78]:26854 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S266901AbUGLRei
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 13:34:38 -0400
Message-ID: <40F2CB97.1070806@zytor.com>
Date: Mon, 12 Jul 2004 10:34:15 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: "R. J. Wysocki" <rjwysocki@sisk.pl>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
Subject: Re: [discuss] Re: Opteron bug
References: <200406192229.14296.rjwysocki@sisk.pl> <20040620152256.4a173a95.ak@suse.de>
In-Reply-To: <20040620152256.4a173a95.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> 
> The kernel never uses backwards REP prefixes.
> 

Not even for memmove()?

	-hpa

