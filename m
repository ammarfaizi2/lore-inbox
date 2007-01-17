Return-Path: <linux-kernel-owner+w=401wt.eu-S932080AbXAQNhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932080AbXAQNhT (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 08:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932083AbXAQNhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 08:37:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.173]:55400 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932080AbXAQNhR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 08:37:17 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jDDjxkpR29hV1lnJShW9rwk0vA7bxY4Q+sqzE0sElf1UUFVyBznqDqupbb0Ivf93nShaU92VnpiEj6yAyZ9kzNEwLCgXP9VHepUFwskcsIlDxxsObbKriOf+khWcYVQSXqQkGw5odfb5u9OUjZBcjeau42KGagwvqwsXzWQJpR4=
Message-ID: <9e0cf0bf0701170537s4bb663a1j2d45b4013da81fbc@mail.gmail.com>
Date: Wed, 17 Jan 2007 15:37:15 +0200
From: "Alon Bar-Lev" <alon.barlev@gmail.com>
To: "Tomasz Chmielewski" <mangoo@wpkg.org>
Subject: Re: kernel cmdline: root=/dev/sdb1,/dev/sda1 "fallback"?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <45AE1D65.4010804@wpkg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45AE1D65.4010804@wpkg.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/07, Tomasz Chmielewski <mangoo@wpkg.org> wrote:
> Does this make sense?

Why not add this logic into your initramfs?

Best Regards,
Alon Bar-Lev.
