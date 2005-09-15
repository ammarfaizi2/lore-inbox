Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030521AbVIOQ3h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030521AbVIOQ3h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 12:29:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030520AbVIOQ3h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 12:29:37 -0400
Received: from amdext4.amd.com ([163.181.251.6]:6117 "EHLO amdext4.amd.com")
	by vger.kernel.org with ESMTP id S1030521AbVIOQ3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 12:29:36 -0400
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
From: "Ray Bryant" <raybry@mpdtxmail.amd.com>
To: "Michael (Micksa) Slade" <micksa@knobbits.org>
Subject: Re: 2.6 breaks my KVM?
Date: Thu, 15 Sep 2005 11:37:49 -0500
User-Agent: KMail/1.8
cc: "Linux Kernel" <linux-kernel@vger.kernel.org>
References: <4327C0EB.9040403@knobbits.org>
In-Reply-To: <4327C0EB.9040403@knobbits.org>
MIME-Version: 1.0
Message-ID: <200509151137.50103.raybry@mpdtxmail.amd.com>
X-WSS-ID: 6F377EEB28G438764-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 September 2005 01:19, Michael (Micksa) Slade wrote:

>
> The mouse misbehaves.  touching the mouse causes the pointer to go
> haywire and jump everywhere, and there's the occasional button click too
> I think.
>
> It happens with both my older logitech mouse and a newer MS
> intellimouse.  Both work fine with 2.6 when plugged in directly.
>
<snip>

Try adding psmouse.proto=bare as a kernel parameter for your 2.6 kernels.

-- 
Ray Bryant
AMD Performance Labs                   Austin, Tx
512-602-0038 (o)                 512-507-7807 (c)

