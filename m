Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292648AbSBZSUW>; Tue, 26 Feb 2002 13:20:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292643AbSBZSRJ>; Tue, 26 Feb 2002 13:17:09 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36370 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292633AbSBZSPG>; Tue, 26 Feb 2002 13:15:06 -0500
Subject: Re: ext3 and undeletion
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Tue, 26 Feb 2002 18:24:01 +0000 (GMT)
Cc: mfedyk@matchmail.com (Mike Fedyk), hpa@zytor.com (H. Peter Anvin),
        linux-kernel@vger.kernel.org
In-Reply-To: <3C7BBDE2.8050207@evision-ventures.com> from "Martin Dalecki" at Feb 26, 2002 05:54:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16fmGg-0001Wv-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So the pain for the sysadmin will certainly not be decreased. Quite
> contrary for what he expects. For the educated user it was always a pain
> in the you know where, to constantly run out of quota space due to
> file versioning.

Netware was somewhat more sensible. Digging out an old file took running
a tool which had a little irritation factor. In addition stuff got
automatically recycled over time and as disk space was needed.
