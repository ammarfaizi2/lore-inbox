Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965624AbWIRJv6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965624AbWIRJv6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 05:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbWIRJv6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 05:51:58 -0400
Received: from wx-out-0506.google.com ([66.249.82.235]:40745 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750744AbWIRJv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 05:51:58 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WieM21qbn3UDK5xTv8hVb7k/9sm0raIEPRQXv+k/k62RVL5qNdTycclwlBS3VG1ZXb+0Bqs5prfz9xG+6rKbd9GiDiQhgXfgoLYvzTaBPSPyzoEWZSuIafQ8IcYUo1vQJ0BNYwqtjtRt49wmK7KxbGTVWY8P9fQ1ma7oMbmPR4E=
Message-ID: <b681c62b0609180251m79071e59oe212b1133bf6944c@mail.gmail.com>
Date: Mon, 18 Sep 2006 15:21:57 +0530
From: "yogeshwar sonawane" <yogyas@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: How much kernel memory is in 64-bit OS ?
In-Reply-To: <b681c62b0609160434g6ccbbaa0vd0cd68958696726e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <b681c62b0609160434g6ccbbaa0vd0cd68958696726e@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/06, yogeshwar sonawane <yogyas@gmail.com> wrote:
> Hi all,
>
> We all know that in 32-bit OS, total 4GB memory space is divided in
> 3(user) + 1(kernel) space.
>
> Similarly, what is the division/scenario in case of 64-bit OS ?
>
> Any reference/explanation will be helpful.
>
> thanks in advance.
>
>
> Yogeshwar
>

On similar lines, some time back, i read that, to accomodate large
physical memory ,
the 3G/1G layout is modified to have 4G/4G partition. But if somebody
can focus the light on following things, it will be helpful.
1) what was the requirement of 4G/4G layout ?
2) how it is managed ?
3) how HIGH_MEMORY concept is related here.

Thanks in advance,
Yogeshwar
