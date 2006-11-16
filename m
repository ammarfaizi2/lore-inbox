Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424226AbWKPQCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424226AbWKPQCH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 11:02:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424229AbWKPQCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 11:02:07 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:59222 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1424226AbWKPQCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 11:02:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=qXJ21OJyCmOCKz2HUOK7u4ETIwI7K9ry0VchphJ43he8Bp6leSbyNXpUNxiT3lNo2jiCVCxWyWGVgNb2iR73lRKbDZyYJKsyETrtFASYQixsXal3Rq5pnzzTKlL+R8sFCDMMducu+NeFqP9Bw9AMlNagEZLiUVRDa72aAVrAa9U=
Message-ID: <455C8B8D.7040801@gmail.com>
Date: Thu, 16 Nov 2006 17:01:58 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: ranjith kumar <ranjit_kumar_b4u@yahoo.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: diabling interrupts on pentium 4 processor
References: <20061116112312.43293.qmail@web27402.mail.ukl.yahoo.com>
In-Reply-To: <20061116112312.43293.qmail@web27402.mail.ukl.yahoo.com>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ranjith kumar wrote:
> Hi,
>     How to disable interrupts on pentium 4 (or any
> i386)
>     machine?
> 
>      I tried to include "cli" instruction in a kernel
> module. But got runtime error.

UTFG and read LDD3

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
