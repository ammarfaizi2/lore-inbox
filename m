Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030324AbWILWN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030324AbWILWN7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 18:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbWILWN7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 18:13:59 -0400
Received: from nf-out-0910.google.com ([64.233.182.186]:17157 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030324AbWILWN6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 18:13:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=fIlI0qfLwyFBxxRMhVZ6eFITDra/m8toNrQ8y9wKxQq/tVDv1EwtqkorvVQWy5S7a/p6av4gxPPEq5dpvKShx/lqwXyungjtlNC1XMX9xU4rTjKODghI6BN50JHMMjDzWvaxWGoZL/Qg8XyDSAuKvtLrS3TE+DxYfC1cB2u9trs=
Message-ID: <4507311D.8080409@gmail.com>
Date: Wed, 13 Sep 2006 00:13:26 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>, Pavel Machek <pavel@ucw.cz>,
       Dave Jones <davej@redhat.com>
Subject: Re: 2.6.18-rc6-mm2
References: <20060912000618.a2e2afc0.akpm@osdl.org> <6bffcb0e0609121211t2dec0e49qb8d3dbfad2476852@mail.gmail.com> <45072E7A.2080701@gmail.com>
In-Reply-To: <45072E7A.2080701@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Michal Piotrowski wrote:
>> On 12/09/06, Andrew Morton <akpm@osdl.org> wrote:
>>>
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.18-rc6/2.6.18-rc6-mm2/ 
>>>
>>>
>>
>> My FC6T2 bug appeared in -mm
>> https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=202223
>>
>> Any ideas about this?
> 
> Hi,
> this is known:
> http://lkml.org/lkml/2006/9/8/56

Of course, you know it, there is a link to the redhat bugzilla in the root post 
of this...

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
