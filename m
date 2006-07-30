Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWG3UMw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWG3UMw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 16:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932467AbWG3UMw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 16:12:52 -0400
Received: from nz-out-0102.google.com ([64.233.162.206]:2106 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932446AbWG3UMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 16:12:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=PSNanlR1tnKhTP2Z43gT0Rnwh2niC3FKzLk60NIsOMci6CSvakAILiD7UJZvfN8wJqtGzO3LXdadZ+mm2vQnImfeqf/oSiLs1v9RBJ4XR0/WzidAHk1y5AqTI9TYQkKwcszArM82GXspLDDEdDuFq2f7ho7PPqHDHsqAWigDES8=
Message-ID: <44CD12C5.8000106@gmail.com>
Date: Sun, 30 Jul 2006 22:12:30 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org, support@moxa.com.tw, bpidoux@free.fr
Subject: Re: [RFC 1/2] Char: mxser, upgrade to 1.9.1
References: <we_have_too_much_work@hehe.blahblah> <20060730123150.883d9121.akpm@osdl.org>
In-Reply-To: <20060730123150.883d9121.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Sat, 29 Jul 2006 15:29:43 -0400
> Jiri Slaby <jirislaby@gmail.com> wrote:
> 
>> mxser, upgrade to 1.9.1
>>
>> Change driver according to original 1.9.1 moxa driver.
> 
> Where did these changes come from?  The Moxa website, perhaps?

Sure.

> Do we know what they do?

Not for sure for each line they changed (it comes from diff between their 2 
versions: 1.8 and 1.9.1).

> Have you been able to test it?

I hope Bernard Pidoux <bpidoux@free.fr> had and did, but we can apply him to 
test this:
Could you, Bernard, test the patch from
http://lkml.org/lkml/diff/2006/7/29/143/1
?

thanks,
-- 
<a href="http://www.fi.muni.cz/~xslaby/">Jiri Slaby</a>
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
