Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267530AbRGPSRt>; Mon, 16 Jul 2001 14:17:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267560AbRGPSRj>; Mon, 16 Jul 2001 14:17:39 -0400
Received: from AMontpellier-201-1-2-148.abo.wanadoo.fr ([193.253.215.148]:23564
	"EHLO awak") by vger.kernel.org with ESMTP id <S267530AbRGPSRb>;
	Mon, 16 Jul 2001 14:17:31 -0400
Subject: Re: 4.1.0 DRM (was Re: Linux 2.4.6-ac3)
From: Xavier Bestel <xavier.bestel@free.fr>
To: Jeff Hartmann <jhartmann@valinux.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, John Cavan <johnc@damncats.org>,
        linux-kernel@vger.kernel.org
In-Reply-To: <3B532BB7.1050300@valinux.com>
In-Reply-To: <E15M6jC-0005PK-00@the-village.bc.nu> 
	<3B532BB7.1050300@valinux.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.10.99 (Preview Release)
Date: 16 Jul 2001 20:12:35 +0200
Message-Id: <995307155.32445.36.camel@nomade>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Jul 2001 12:00:23 -0600, Jeff Hartmann wrote:
[...]
> will do this.  This will make the 4.0 -> 4.1 have to be a compile time 
> decision, but 4.1 -> 4.1.1 and higher will just coexist with each 
> other.  I'm currently working out integrating this into the kernel 
> build, and I should hopefully have a patch for Linus and Alan soon.

I would have preferred if you were just versionning vs the API, not the
X version (and keep the API rather stable). I wouldn't like to update my
kernel just to go from X 4.1.1 to X 4.1.1-pl1.

Xav

