Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129624AbQKFXy1>; Mon, 6 Nov 2000 18:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130297AbQKFXyR>; Mon, 6 Nov 2000 18:54:17 -0500
Received: from smtp-fwd.valinux.com ([198.186.202.196]:1542 "EHLO
	mail.valinux.com") by vger.kernel.org with ESMTP id <S129624AbQKFXyG>;
	Mon, 6 Nov 2000 18:54:06 -0500
Date: Mon, 6 Nov 2000 15:54:48 -0800
From: David Hinds <dhinds@valinux.com>
To: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Cc: David Ford <david@linux.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: current snapshots of pcmcia
Message-ID: <20001106155448.C19860@valinux.com>
In-Reply-To: <3A06757F.3C63F1A8@linux.com> <20001106104927.A19573@valinux.com> <3A073C8D.B6511746@linux.com> <20001106154039.A19860@valinux.com> <3A0742B0.653A5AAF@timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.6i
In-Reply-To: <3A0742B0.653A5AAF@timpanogas.org>; from Jeff V. Merkey on Mon, Nov 06, 2000 at 04:45:52PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2000 at 04:45:52PM -0700, Jeff V. Merkey wrote:
> 
> On a related topic, I've pulled down your stuff at sourceforge and we
> are using it for our 2.4 build.  Is this the baest place or do you have
> somewhere more recent and is this the list to report bugs?  We have seen
> some problems with IBM thinkpads with DSP devices having some issues
> (like the volume control doesn't work right on 2.4).  Most are just
> annoyances and what I would classify as level IV bugs (very
> non-critical).

The sourceforge site is the most up to date place for PCMCIA.  That is
the best place to report bugs that are specific to that code.  For
bugs that are specific to things in the 2.4 tree and/or have to do
with how PCMCIA interacts with other subsystems (i.e., the problem
that started this thread, where I think the problem is in the PCI
subsystem), then linux-kernel is probably a better place.

-- Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
