Return-Path: <linux-kernel-owner+w=401wt.eu-S1030398AbWLOX40@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbWLOX40 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 18:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbWLOX40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 18:56:26 -0500
Received: from nf-out-0910.google.com ([64.233.182.188]:65187 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030401AbWLOX4X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 18:56:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:x-enigmail-version:content-type:content-transfer-encoding;
        b=LY2zv2rvyWCiVf2iL4fhV3bF23Y02Z0nb3J9khsdi2TUJY135eLDuG5MIfnVLW4wvUApVEhrwA+1Eu9Comf0Uk2WINhIOcNzH0JCEdS+xbr5m00M6mxOrzEZPqxC5c72vnUYUuM5p5T2+pt2w1K/ubI/Fg2c/C6EaszF6fG+3ds=
Message-ID: <45833620.2040902@gmail.com>
Date: Sat, 16 Dec 2006 00:55:53 +0059
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@it.uu.se>
CC: akpm@osdl.org, jgarzik@pobox.com, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: OOPS: deref 0x14 at pdc_port_start+0x82 [Was: 2.6.20-rc1-mm1]
References: <200612152335.kBFNZ0tu003064@harpo.it.uu.se>
In-Reply-To: <200612152335.kBFNZ0tu003064@harpo.it.uu.se>
X-Enigmail-Version: 0.94.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> Applying the trivial patch below on top of 2.6.20-rc1-mm1 should

Yup, Jeff fwd me this yet and it works.

thanks,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
