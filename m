Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265972AbRGCTiL>; Tue, 3 Jul 2001 15:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265971AbRGCTiB>; Tue, 3 Jul 2001 15:38:01 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:56747 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S265972AbRGCThn>;
	Tue, 3 Jul 2001 15:37:43 -0400
Message-ID: <3B421F04.305FEE03@mandrakesoft.com>
Date: Tue, 03 Jul 2001 15:37:40 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.6-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        "Acpi-linux (E-mail)" <acpi@phobos.fachschaften.tu-muenchen.de>
Subject: Re: ACPI fundamental locking problems
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDF2B@orsmsx35.jf.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Other ACPI problems, that come with the increased potential for
malicious code:
- Much easier for NSA to snoop machine activity undetected (hello
paranoid people)
- Much easier to write worms and virii and similar

(it's much easier for someone malicious to patch an acpi table than bios
binary code.....)

-- 
Jeff Garzik      | "I respect faith, but doubt is
Building 1024    |  what gives you an education."
MandrakeSoft     |           -- Wilson Mizner
