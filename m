Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135378AbRDRVsj>; Wed, 18 Apr 2001 17:48:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135380AbRDRVsa>; Wed, 18 Apr 2001 17:48:30 -0400
Received: from fmfdns02.fm.intel.com ([132.233.247.11]:15325 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S135378AbRDRVsM>; Wed, 18 Apr 2001 17:48:12 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDDD9D@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'John Fremlin'" <chief@bandits.org>
Cc: "'Simon Richter'" <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        "Acpi-PM (E-mail)" <linux-power@phobos.fachschaften.tu-muenchen.de>,
        "'Pavel Machek'" <pavel@suse.cz>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        linux-kernel@vger.kernel.org
Subject: RE: Let init know user wants to shutdown
Date: Wed, 18 Apr 2001 14:46:16 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: John Fremlin [mailto:chief@bandits.org]
> [...]
> 
> > Fair enough. I don't think I would be out of line to say that our
> > resources are focused on enabling full ACPI functionality for Linux,
> > including a full-featured PM policy daemon. That said, I don't think
> > there's anything precluding the use of another daemon (or whatever)
> > from using the ACPI driver's interface.
> 
> ACPI != PM. I don't see why ACPI details should be exposed to PM
> interface at all.

ACPI has by far the richest set of capabilities. It is a superset of APM.
Therefore a combined APM/ACPI interface is going to look a lot like an ACPI
interface.

IMHO an abstracted interface at this point is overengineering. Maybe later
it will make sense, though.

Regards -- Andy

