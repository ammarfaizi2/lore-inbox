Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266527AbSLDNKT>; Wed, 4 Dec 2002 08:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266528AbSLDNKT>; Wed, 4 Dec 2002 08:10:19 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:56512 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S266527AbSLDNKS>;
	Wed, 4 Dec 2002 08:10:18 -0500
Date: Wed, 4 Dec 2002 13:15:14 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Alex Bennee <alex@braddahead.com>
Cc: linux-kernel@vger.kernel.org, eich@suse.de
Subject: Re: Ctrl-Alt-Backspace kills machine not X. ACPI?
Message-ID: <20021204131514.GG647@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alex Bennee <alex@braddahead.com>, linux-kernel@vger.kernel.org,
	eich@suse.de
References: <1039005946.2366.25.camel@cambridge.braddahead>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1039005946.2366.25.camel@cambridge.braddahead>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 04, 2002 at 12:45:45PM +0000, Alex Bennee wrote:

 > I've been running into problems with my machine locking up in X but
 > however I have been unable to diagnose it because the Ctrl-Alt-Backspace
 > key sequence kills my whole machine (i.e. powers it down).

ISTR reading something about this a while ago.
Some chipset vendor had the bright idea to make that the 'quick power
off' sequence.  I think Egbert Eich (cc'd) came up with a hack to
stop it.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
