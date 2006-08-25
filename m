Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbWHYXQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbWHYXQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 19:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932261AbWHYXQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 19:16:57 -0400
Received: from nf-out-0910.google.com ([64.233.182.185]:15452 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932218AbWHYXQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 19:16:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=J/MS4aKN8ghWlXF4fMxgyvoIV5IfKSiH2t8AFpYCpiwcB6GyzFuaqeVvJXwIkc+PiWtB9wiqtBh2qsY1CGA56E3+3yRVjBHpDYIlMZcyqNai6NeiViN+mLs9swp7IU5MUSyGB3EtKVAMeDHbG/n17AMTFl0h43Myfaf0/WXe5MI=
Message-ID: <44EF84DB.4080804@gmail.com>
Date: Sat, 26 Aug 2006 01:16:20 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: "Brian D. McGrew" <brian@visionpro.com>
CC: linux-kernel@vger.kernel.org,
       For users of Fedora Core releases 
	<fedora-list@redhat.com>
Subject: Re: mounting Floppy and USB - 2.6.16.16
References: <14CFC56C96D8554AA0B8969DB825FEA001A651DF@chicken.machinevisionproducts.com>
In-Reply-To: <14CFC56C96D8554AA0B8969DB825FEA001A651DF@chicken.machinevisionproducts.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian D. McGrew wrote:
> Hey Guys:
> 
> With 2.4.20 and 2.6.9 I had all this automated so everything just
> happened automatically.  It's not working with 2.6.16.16 now.  What am I
> missing or what did I forget?

Yeah, there was an issue like that, but I don't know what from triple 
[kernel/udev/hal] made it working again. Try to upgrade each part (even from 
devel tree) to [2.6.18-rc4/095/0.5.7.1] and see what happens.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
