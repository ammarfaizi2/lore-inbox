Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135271AbRDRThk>; Wed, 18 Apr 2001 15:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135270AbRDRTha>; Wed, 18 Apr 2001 15:37:30 -0400
Received: from m180-mp1-cvx1b.col.ntl.com ([213.104.72.180]:29824 "EHLO
	[213.104.72.180]") by vger.kernel.org with ESMTP id <S135269AbRDRThY>;
	Wed, 18 Apr 2001 15:37:24 -0400
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Simon Richter'" <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        "'Pavel Machek'" <pavel@suse.cz>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDD9A@orsmsx35.jf.intel.com>
From: John Fremlin <chief@bandits.org>
Date: 18 Apr 2001 20:36:38 +0100
In-Reply-To: "Grover, Andrew"'s message of "Wed, 18 Apr 2001 11:28:52 -0700"
Message-ID: <m2y9sy3sqh.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 "Grover, Andrew" <andrew.grover@intel.com> writes:

[...]

> Fair enough. I don't think I would be out of line to say that our
> resources are focused on enabling full ACPI functionality for Linux,
> including a full-featured PM policy daemon. That said, I don't think
> there's anything precluding the use of another daemon (or whatever)
> from using the ACPI driver's interface.

ACPI != PM. I don't see why ACPI details should be exposed to PM
interface at all.

[...]

-- 

	http://www.penguinpowered.com/~vii
