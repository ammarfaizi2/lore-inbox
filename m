Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130252AbRCPHQq>; Fri, 16 Mar 2001 02:16:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130399AbRCPHQg>; Fri, 16 Mar 2001 02:16:36 -0500
Received: from [63.95.87.168] ([63.95.87.168]:18948 "HELO xi.linuxpower.cx")
	by vger.kernel.org with SMTP id <S130252AbRCPHQb>;
	Fri, 16 Mar 2001 02:16:31 -0500
Date: Fri, 16 Mar 2001 02:15:20 -0500
From: Gregory Maxwell <greg@linuxpower.cx>
To: Johannes Erdfelt <jerdfelt@valinux.com>
Cc: alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: 2.2 and AMD-760MP I/O APIC
Message-ID: <20010316021520.B1864@xi.linuxpower.cx>
In-Reply-To: <20010315173418.G25511@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.8i
In-Reply-To: <20010315173418.G25511@valinux.com>; from jerdfelt@valinux.com on Thu, Mar 15, 2001 at 05:34:18PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2001 at 05:34:18PM -0800, Johannes Erdfelt wrote:
> The I/O APIC code for 2.2 contains a little trick which sets the destination
> to 0 to disable an I/O APIC entry. This apparently trips up the I/O APIC
> on AMD-760MP systems causing a lockup during boot.
[snip]

I'd love you test your patch! What does it take to become equipt with such a
motherboard? <snicker>
