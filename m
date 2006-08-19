Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964978AbWHSKcO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964978AbWHSKcO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 06:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbWHSKcO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 06:32:14 -0400
Received: from py-out-1112.google.com ([64.233.166.182]:15657 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964978AbWHSKcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 06:32:13 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dBNor8aVaaHmjmbqxaYZEBnCZos2MU4n0c/GChhXpdzt/v0hNEbQKkRpGq1bmf2uhYVM30/3vk4f4rzrj045TnzL87QzwMvJgHkVeL1QKnjUyJ6UsuyHz1bu2tGcnQVSWv6LHYbEhl2LYEskq8KZqvV9d3mN7SXEn6XxafFZ1ow=
Message-ID: <6bffcb0e0608190332o445c5357tc7698e224de6f7a7@mail.gmail.com>
Date: Sat, 19 Aug 2006 12:32:13 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [PATCH 2.6.18-rc4 00/10] Kernel memory leak detector 0.9
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b0943d9e0608190327h6ec3bb17wf32517af1fbf6d12@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060812215857.17709.79502.stgit@localhost.localdomain>
	 <6bffcb0e0608180655j50332247m8ed393c37d570ee4@mail.gmail.com>
	 <6bffcb0e0608180715v27015481vb7c603c4be356a21@mail.gmail.com>
	 <b0943d9e0608180846s4ed560b7ld4e3081bdc754454@mail.gmail.com>
	 <6bffcb0e0608180942l12e342epd60dffbb5c5d4b3e@mail.gmail.com>
	 <b0943d9e0608180957w60d22261k61b272c9b76505bd@mail.gmail.com>
	 <6bffcb0e0608181438m3406de08q9a168d486127aef@mail.gmail.com>
	 <b0943d9e0608181447t5503b24eyfea6f3903c2ba27d@mail.gmail.com>
	 <6bffcb0e0608181549o3034398fob3763d3ce0869cfe@mail.gmail.com>
	 <b0943d9e0608190327h6ec3bb17wf32517af1fbf6d12@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/08/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
[snip]
> Have you seen any crashes or lockdep reports with the latest kmemleak patches?

12 hours of uptime - without any problems :).

>
> --
> Catalin
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
