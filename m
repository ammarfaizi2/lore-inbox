Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135544AbRDSEGs>; Thu, 19 Apr 2001 00:06:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135543AbRDSEGi>; Thu, 19 Apr 2001 00:06:38 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:7691 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S135539AbRDSEGc>; Thu, 19 Apr 2001 00:06:32 -0400
Subject: Re: Next gen PM interface
To: chief@bandits.org (John Fremlin)
Date: Thu, 19 Apr 2001 05:07:57 +0100 (BST)
Cc: linux-power@phobos.fachschaften.tu-muenchen.de ("Acpi-PM (E-mail)"),
        linux-kernel@vger.kernel.org
In-Reply-To: <m2d7a97ddb.fsf_-_@bandits.org> from "John Fremlin" at Apr 19, 2001 04:54:56 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14q5jc-0006OD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is flexible and simple. It means a reasonable default behaviour
> can be suggested by the kernel (OFF,SLEEP,etc.) for events that
> userspace doesn't know about and yet userspace can choose fine grained
> policy and provide helpful error messages based on the exact event by

The entire PM layer for the embedded board I worked on was 3Kbytes. How small
will yours be 8)

