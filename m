Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261754AbSIXS3i>; Tue, 24 Sep 2002 14:29:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261758AbSIXS3i>; Tue, 24 Sep 2002 14:29:38 -0400
Received: from gherkin.frus.com ([192.158.254.49]:11419 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S261754AbSIXS3h>;
	Tue, 24 Sep 2002 14:29:37 -0400
Message-Id: <m17tuWJ-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: Re: UP IO-APIC
In-Reply-To: <Pine.LNX.4.44.0209241359340.12397-100000@montezuma.mastecende.com>
 "from Zwane Mwaikambo at Sep 24, 2002 02:04:33 pm"
To: linux-kernel@vger.kernel.org
Date: Tue, 24 Sep 2002 13:34:51 -0500 (CDT)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Tue, 24 Sep 2002, Ricky Beam wrote:
> 
> > It works in 2.4, but I've never seen it work in 2.5 -- but I've not compiled
> > every 2.5.X.  Neither the local APIC or IO APIC work in non-SMP configurations
> 
> I've been using it since inception with local APIC, UP-IOAPIC broke a 
> couple of times only.

My Dell notebook has an APIC, but it has gotten disabled automatically
at boot time ever since someone labeled my BIOS as broken :-).  FWIW,
I don't disagree with the "broken" label.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
