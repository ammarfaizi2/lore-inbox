Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbUCEVDQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 16:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbUCEVDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 16:03:16 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:30736 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262713AbUCEVC7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 16:02:59 -0500
Message-ID: <4048EADF.1060601@zytor.com>
Date: Fri, 05 Mar 2004 13:02:23 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031030
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Mike Fedyk <mfedyk@matchmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] UTF-8ifying the kernel source
References: <20040304100503.GA13970@havoc.gtf.org> <buovfljbsyl.fsf@mcspd15.ucom.lsi.nec.co.jp> <c2ambg$9rs$1@terminus.zytor.com> <4048EA87.1080304@matchmail.com>
In-Reply-To: <4048EA87.1080304@matchmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk wrote:
>>
>> OK, this is definitely a good reason to go to UTF-8 across the board.
> 
> So when is "less" going to support utf8?  Right now, it just shows
> escape codes... :(
>

Why don't you ask the "less" maintainer about that?

Right now, "less" seems to insist on showing ampersands for *any*
non-ASCII character for me...

	-hpa

