Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316933AbSEVKfs>; Wed, 22 May 2002 06:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316934AbSEVKfr>; Wed, 22 May 2002 06:35:47 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:7699 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S316933AbSEVKfr>;
	Wed, 22 May 2002 06:35:47 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200205221035.g4MAZN9103286@saturn.cs.uml.edu>
Subject: Re: suspend-to-{RAM,disk} for 2.5.17
To: dalecki@evision-ventures.com (Martin Dalecki)
Date: Wed, 22 May 2002 06:35:22 -0400 (EDT)
Cc: xavier.bestel@free.fr (Xavier Bestel),
        torvalds@transmeta.com (Linus Torvalds), pavel@ucw.cz (Pavel Machek),
        linux-kernel@vger.kernel.org (Linux Kernel Mailing List),
        acpi-devel@lists.sourceforge.net (ACPI mailing list)
In-Reply-To: <3CEB5EF4.604@evision-ventures.com> from "Martin Dalecki" at May 22, 2002 11:03:48 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki writes:
> Uz.ytkownik Xavier Bestel napisa?:

>> Compressing pages will speed up the process, and doing it on the fly
>
> Did you ever in you life tar czvf ./some_dir and have a look at top?!

lzo isn't such a CPU hog
