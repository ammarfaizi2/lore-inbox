Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281129AbRLDRIZ>; Tue, 4 Dec 2001 12:08:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281703AbRLDRGj>; Tue, 4 Dec 2001 12:06:39 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36356 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S281124AbRLDRGL>; Tue, 4 Dec 2001 12:06:11 -0500
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
To: matthias.andree@stud.uni-dortmund.de (Matthias Andree)
Date: Tue, 4 Dec 2001 17:15:07 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, hch@caldera.de (Christoph Hellwig),
        esr@thyrsus.com (Eric S. Raymond), kaos@ocs.com.au (Keith Owens),
        kbuild-devel@lists.sourceforge.net, torvalds@transmeta.com
In-Reply-To: <20011204173309.A10746@emma1.emma.line.org> from "Matthias Andree" at Dec 04, 2001 05:33:09 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16BJ9v-0002ii-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Creating a dependency on Python? Is a non-issue. Current systems that
> are to run 2.5 or 2.6 are bloated beyond belief by glibc already, Python
> is nice and it does not create such unmaintainable mess. Whether

Python2 - which means most users dont have it.

