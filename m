Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbUCEVR4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 16:17:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbUCEVR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 16:17:56 -0500
Received: from main.gmane.org ([80.91.224.249]:7083 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262709AbUCEVRy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 16:17:54 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: [PATCH] UTF-8ifying the kernel source
Date: Fri, 05 Mar 2004 22:17:51 +0100
Message-ID: <yw1xsmgnc7sw.fsf@kth.se>
References: <20040304100503.GA13970@havoc.gtf.org> <buovfljbsyl.fsf@mcspd15.ucom.lsi.nec.co.jp>
 <c2ambg$9rs$1@terminus.zytor.com> <4048EA87.1080304@matchmail.com>
 <4048EADF.1060601@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: ti211310a080-4136.bb.online.no
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:UkYkiWcNcg99L8JWewrys6s7LB4=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" <hpa@zytor.com> writes:

> Mike Fedyk wrote:
>>>
>>> OK, this is definitely a good reason to go to UTF-8 across the board.
>> 
>> So when is "less" going to support utf8?  Right now, it just shows
>> escape codes... :(
>>
>
> Why don't you ask the "less" maintainer about that?
>
> Right now, "less" seems to insist on showing ampersands for *any*
> non-ASCII character for me...

Less version 381 is working fine here with UTF-8.  I have LANG and
LC_CTYPE set to en_US.UTF-8.

-- 
Måns Rullgård
mru@kth.se

