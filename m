Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269683AbUJMMUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269683AbUJMMUI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 08:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269688AbUJMMUH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 08:20:07 -0400
Received: from smtp.infolink.com.br ([200.187.64.6]:48393 "EHLO
	smtp.infolink.com.br") by vger.kernel.org with ESMTP
	id S269683AbUJMMUD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 08:20:03 -0400
Message-ID: <416D1D6F.4080508@silexonline.org>
Date: Wed, 13 Oct 2004 09:19:59 -0300
From: Haroldo Gamal <haroldo.gamal@silexonline.org>
Reply-To: haroldo.gamal@silexonline.org
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Submitting patches for unmaintained areas (Solaris x86 UFS bug)
References: <c461c0d10410130406714fafe3@mail.gmail.com>
In-Reply-To: <c461c0d10410130406714fafe3@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've done have done the same with 
http://bugzilla.kernel.org/show_bug.cgi?id=3330 and I have the same 
question!

Where do I go from now?

Haroldo Gamal

Alex Kiernan wrote:

>I've run into a bug in the UFS reading code (on Solaris x86 the
>major/minor numbers are in 2nd indirect offset not the first), so I've
>patched it & bugzilled it
>(http://bugzilla.kernel.org/show_bug.cgi?id=3475).
>
>But where do I go from here? There doesn't seem to be a maintainer for
>UFS so I can't send it there.
>
>  
>

