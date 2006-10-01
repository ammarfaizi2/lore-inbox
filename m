Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWJAR6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWJAR6P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Oct 2006 13:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWJAR6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Oct 2006 13:58:15 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:21262 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932140AbWJAR6O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Oct 2006 13:58:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BLVCHnSQuaAF6KYe2BDRHAf/yo0m26wCBEZ2GpJ7n40jgkKpH3XQFld0Sls1gxHB5uvPV+MvLYzmDo6Dd+Mc0Nen6LN2OKg8Xj8ngWzQBVHqMdczRxlg8gvbFv0jWAERPTXfsIvSPjSJtEo2GTkXMFCg+NhxZYG3YKaa+Jvrd0g=
Message-ID: <653402b90610011058k69ded913yfc8e9a822fb1800a@mail.gmail.com>
Date: Sun, 1 Oct 2006 19:58:13 +0200
From: "Miguel Ojeda" <maxextreme@gmail.com>
To: "Stefan Richter" <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 2.6.18 V7] drivers: add lcd display support
Cc: akpm@osdl.org, "Randy Dunlap" <rdunlap@xenotime.net>,
       linux-kernel@vger.kernel.org
In-Reply-To: <451FF176.7090500@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060930232445.59e8adf6.maxextreme@gmail.com>
	 <653402b90610010553p23819d2bsd7a07fabaee7ecf3@mail.gmail.com>
	 <451FC7DC.7070909@s5r6.in-berlin.de>
	 <653402b90610010725l7862ff9fy2b1c072caedaff24@mail.gmail.com>
	 <451FF176.7090500@s5r6.in-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/1/06, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> LCD is in Spanish, as in German, a foreign term. But still, its D is
> carrying the meaning of "display" or its native equivalent. ("Display"
> itself is even in common use in Spain, Germany, and many other
> countries.) In German, "display" may be translated to "Anzeige",
> "Bildschirm", "Display", "Monitor"; and any of "LCD-Anzeige",
> "LCD-Bildschirm", "LCD-Display", "LCD-Monitor" would be bad style.
> ("LCD-Display" would clearly be the worst of all, because one could
> argue that a display is just a part of a monitor, thus "LCD monitor" is
> arguably less redundant than "LCD display"...)

I'm not saying it is the right way, just I'm saying which is the
common way to say it in Spanish: We say "LCD" as "pantalla LCD"; and
althought "pantalla" means "display", it is more expressive that way.
We use "LCD" as a kind of display.

Yeah, we should use "pantalla LC", but we don't. However, in formal
written language, you should write just "LCD", like in English,
because it is wrong such "pantalla LCD".

Whatever. The point is that in English "LCD Display" is bad.
