Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311752AbSDBMyz>; Tue, 2 Apr 2002 07:54:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311900AbSDBMyp>; Tue, 2 Apr 2002 07:54:45 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:46845 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S311752AbSDBMyb>; Tue, 2 Apr 2002 07:54:31 -0500
Message-ID: <3CA9A9FE.8B200EF5@redhat.com>
Date: Tue, 02 Apr 2002 13:54:22 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-26beta.51smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UP IO-APIC with ACPI table but no MP table?
In-Reply-To: <15529.39198.444056.901156@kim.it.uu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson wrote:
> 
> Is it possible to get the kernel to recognise and utilise the
> chipset's IO-APIC if the BIOS has no MP table but does list the
> IO-APIC in the ACPI table(s)?

the mini acpi does this or at least can do it; right now it's not
compiled in for UP though
