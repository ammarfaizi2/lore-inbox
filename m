Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpP7DKBB5+wHKRbWnbOBISzVioA==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Tue, 06 Jan 2004 06:22:36 +0000
Message-ID: <048201c415a4$fec35310$d100000a@sbs2003.local>
Content-Class: urn:content-classes:message
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Subject: Re: ACPI battery problem with 2.6.1-rc1-mm2 kernel patch
From: "Dax Kelson" <dax@gurulabs.com>
To: <Administrator@smtp.paston.co.uk>
Cc: "Andrew Morton" <akpm@osdl.org>, "Yu, Luming" <luming.yu@intel.com>,
        "Jean-Marc Valin" <Jean-Marc.Valin@USherbrooke.ca>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@intel.com>
In-Reply-To: <200401060259.i062xrb3002240@turing-police.cc.vt.edu>
References: <1073354003.4101.11.camel@idefix.homelinux.org> <20040105180859.7e20e87a.akpm@osdl.org> <200401060259.i062xrb3002240@turing-police.cc.vt.edu>
Content-Type: text/plain;
	charset="iso-8859-1"
MIME-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 29 Mar 2004 16:46:26 +0100
Content-Transfer-Encoding: 7bit
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:46:27.0359 (UTC) FILETIME=[FF3352F0:01C415A4]

On Mon, 2004-01-05 at 19:59, Valdis.Kletnieks@vt.edu wrote:
> On Mon, 05 Jan 2004 18:08:59 PST, Andrew Morton said:
> 
> > Thanks, the acpi-20031203 patch seems to have introduced a handful of
> > regressions.
> 
> As suggested by Yu Luming, the patch at http://bugzilla.kernel.org/show_bug.cgi?id=1766
> is confirmed to fix my issue.  2.6.1-rc1-mm2 with that patch gives me:

Just confirming that the same patched fixed up the battery reporting
problems on my laptop as well.

Dax Kelson
Guru Labs

