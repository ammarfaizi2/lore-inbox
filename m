Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1754341AbWKRKdr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754341AbWKRKdr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Nov 2006 05:33:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754344AbWKRKdr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Nov 2006 05:33:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.169]:12888 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1754337AbWKRKdq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Nov 2006 05:33:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=meG4Ke9IUxIRRt36sZuC0GQ2qG8y8dIelXHhgH7cFrmJxw0mahr+L18SYdBV2Tx4ffuQCErul18dVFQALoBR1IAN6SYGeQufP/TzDUTgOQ7A2TNrdeKu2pBH+XoQrSrxWMl6E08b9vcEiSq+Mm7lcDn551OQ8gR5WNniZKrg3wU=
Message-ID: <455EE1A4.2070103@gmail.com>
Date: Sat, 18 Nov 2006 11:33:49 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
CC: Oleg Verych <olecom@flower.upol.cz>, linux-kernel@ckeith.clara.net
Subject: Re: "Unable to handle kernel NULL pointer dereference" in 2.6.18.2
 (2.6.18-1.2239.fc5)
References: <20061117184630.GV26200@dot.oreally.co.uk> <slrnelt3dm.dd3.olecom@flower.upol.cz>
In-Reply-To: <slrnelt3dm.dd3.olecom@flower.upol.cz>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg, do not remove CC people, please!

Oleg Verych wrote:
> On 2006-11-17, somebody from ckeith.clara.net wrote:
> []
>> dmesg is attached below, if anything else is needed please let me know.
>> And if any one knows of any older kernels that are more stable for this
>> hardware configuration (2x dual core opteron 2220SE's with aacraid) please
>> let me know.
> 
> Noone, but you. But i would ask you to check *newer* kernel.
> Please check last available 2.6.19-rc6 from  kernel.org one.

And if it doesn't help, file a bug at bugzilla.kernel.org (or
bugzilla.redhat.com if you are not willing to test fresh vanilla -- they have
many patches in their kernel), please.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
