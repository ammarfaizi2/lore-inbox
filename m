Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbVILRUm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbVILRUm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 13:20:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbVILRUm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 13:20:42 -0400
Received: from terminus.zytor.com ([209.128.68.124]:34695 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1751081AbVILRUl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 13:20:41 -0400
Message-ID: <4325B85C.2070402@zytor.com>
Date: Mon, 12 Sep 2005 10:18:20 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: mrmacman_g4@mac.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       bunk@stusta.de
Subject: Re: [RFC][MEGAPATCH] Change __ASSEMBLY__ to __ASSEMBLER__ (defined
 by GCC from 2.95 to current CVS)
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com>	<20050903064124.GA31400@codepoet.org>	<4319BEF5.2070000@zytor.com>	<B9E70F6F-CC0A-4053-AB34-A90836431358@mac.com>	<dfhs4u$1ld$1@terminus.zytor.com>	<5A37B032-9BBD-4AEA-A9BF-D42AFF79BC86@mac.com>	<9C47C740-86CF-48F1-8DB6-B547E5D098FF@mac.com>	<97597F8E-DDCE-479F-AE8D-CC7DC75AB3C3@mac.com>	<20050910014543.1be53260.akpm@osdl.org>	<4FAE9F58-7153-4574-A2C3-A586C9C3CFF1@mac.com>	<20050910150446.116dd261.akpm@osdl.org>	<E352D8E3-771F-4A0D-9403-DBAA0C8CBB83@mac.com>	<20050910174818.579bc287.akpm@osdl.org>	<93E9C5F9-A083-4322-A580-236E2232CCC0@mac.com>	<20050912010954.70ac90e2.pj@sgi.com>	<43259C9E.1040300@zytor.com> <20050912084756.4fa2bd07.pj@sgi.com>
In-Reply-To: <20050912084756.4fa2bd07.pj@sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:
> 
> Why must the ABI headers be included by both kernel and user headers to
> be sane?
> 

Version creep.

	-hpa
