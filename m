Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbUFKGIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbUFKGIu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 02:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261865AbUFKGIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 02:08:50 -0400
Received: from s-smtp-osl-02.bluecom.no ([62.101.193.41]:33685 "EHLO
	s-smtp-osl-02.bluecom.no") by vger.kernel.org with ESMTP
	id S261802AbUFKGIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 02:08:49 -0400
Message-ID: <40C94C70.3090502@globelan.net>
Date: Fri, 11 Jun 2004 08:08:48 +0200
From: Lars Age Kamfjord <lakmailing@globelan.net>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: stian@nixia.no
Subject: Re: timer + fpu stuff locks my console race
References: <20040610210042.GL31653@mail.hex.no>
In-Reply-To: <20040610210042.GL31653@mail.hex.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This bug seems VERY serious.... Every machine I've tested with so far 
has crashed totally; and it happens with every version of 2.4 and 
2.6-kernels. I've tested with a 2.2.19-kernel, and that didn't crash, so 
it seems to be a bug in 2.4 and later..... Somebody really should look 
at this......


Lars Age Kamfjord
