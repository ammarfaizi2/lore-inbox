Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135399AbRDRWJ7>; Wed, 18 Apr 2001 18:09:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135403AbRDRWJt>; Wed, 18 Apr 2001 18:09:49 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41856 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135399AbRDRWJb>;
	Wed, 18 Apr 2001 18:09:31 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15070.4248.813990.765006@pizda.ninka.net>
Date: Wed, 18 Apr 2001 15:09:28 -0700 (PDT)
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'John Fremlin'" <chief@bandits.org>,
        "'Simon Richter'" <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        "'Pavel Machek'" <pavel@suse.cz>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        linux-kernel@vger.kernel.org
Subject: RE: Let init know user wants to shutdown
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDD9D@orsmsx35.jf.intel.com>
In-Reply-To: <4148FEAAD879D311AC5700A0C969E89006CDDD9D@orsmsx35.jf.intel.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Grover, Andrew writes:
 > IMHO an abstracted interface at this point is overengineering.

ACPI is the epitome of overengineering.

An abstracted interface would allow simpler systems to avoid all of
the bloated garbage ACPI brings with it.  Sorry, Alan hit it right on
the head, ACPI is not much more than keeping speedstep proprietary.

Later,
David S. Miller
davem@redhat.com
