Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264500AbUF0WGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264500AbUF0WGf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jun 2004 18:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264501AbUF0WGf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jun 2004 18:06:35 -0400
Received: from hell.org.pl ([212.244.218.42]:29197 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S264500AbUF0WGe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jun 2004 18:06:34 -0400
Date: Mon, 28 Jun 2004 00:06:38 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: Hamie <hamish@travellingkiwi.com>
Cc: Alexander Gran <alex@zodiac.dnsalias.org>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] No APIC interrupts after ACPI suspend
Message-ID: <20040627220638.GA1816@hell.org.pl>
Mail-Followup-To: Hamie <hamish@travellingkiwi.com>,
	Alexander Gran <alex@zodiac.dnsalias.org>,
	linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
References: <1088160505.3702.4.camel@tyrosine> <40DDBA7A.6010404@travellingkiwi.com> <40DF0A98.9040604@travellingkiwi.com> <200406272052.43326@zodiac.zodiac.dnsalias.org> <40DF1D22.2010406@travellingkiwi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
In-Reply-To: <40DF1D22.2010406@travellingkiwi.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Hamie:
> Since it sounds like a different bug to 2643, (Similiar but the patch 
> that fixes the ethernet doesn't appear to doa  lot for the sound). I've 
> opened a new one... #2965.

... which might be similar to http://bugme.osdl.org/show_bug.cgi?id=2752,
except that I don't have the IO-APIC running.

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
