Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262589AbUKXJ7u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbUKXJ7u (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 04:59:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbUKXJ7u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 04:59:50 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:1816 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262589AbUKXJ7U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 04:59:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=uMszcvYBuwVXqegOpyma2appu9Vkhk2Iou9VlxIhhfFSGtF/oEWKCDjHlj3OL5ZQWPFgmPUHoVzbZDZ/wBfSVtP46N4yBpv+EWVW/kvQA9L49amb0v7aQJRPKsUwxzasVrHD7NJHlnYWSAEPTsq22ejwS59QsAXZSmTNP+WmfOk=
Message-ID: <b2fa632f04112401525be8b88b@mail.gmail.com>
Date: Wed, 24 Nov 2004 15:22:31 +0530
From: Raj <inguva@gmail.com>
Reply-To: Raj <inguva@gmail.com>
To: Colin Leroy <colin@colino.net>
Subject: Re: Delay in unmounting a USB pen drive
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041124103816.0a8d4183@pirandello>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <b2fa632f041124012543876b61@mail.gmail.com>
	 <20041124103816.0a8d4183@pirandello>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Lucky you :) If your key is fat or vfat, you could try these two patches
> and mount your USB key with -o sync option, your feedback interests me.
> It should make the copies to key slower, but the umount immediate.

Yes, my key is vfat. I shall try out the vfat patch & post the
results. It might
take some time, coz i am building a 2.9 gnome right now. Will keep the list
posted with the results.

Thx

-- 
######
raj
######
