Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265787AbTATNNi>; Mon, 20 Jan 2003 08:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265791AbTATNNi>; Mon, 20 Jan 2003 08:13:38 -0500
Received: from noodles.codemonkey.org.uk ([213.152.47.19]:26054 "EHLO
	noodles.internal") by vger.kernel.org with ESMTP id <S265787AbTATNNh>;
	Mon, 20 Jan 2003 08:13:37 -0500
Date: Mon, 20 Jan 2003 13:19:58 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Alessandro Suardi <ALESSANDRO.SUARDI@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: "Latitude with broken BIOS" ?
Message-ID: <20030120131958.GB27417@codemonkey.org.uk>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Alessandro Suardi <ALESSANDRO.SUARDI@oracle.com>,
	linux-kernel@vger.kernel.org
References: <7346727.1043065918456.JavaMail.nobody@web11.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7346727.1043065918456.JavaMail.nobody@web11.us.oracle.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 20, 2003 at 04:31:58AM -0800, Alessandro Suardi wrote:


 >   I was hoping to use HT on my new Latitude C640 (P4 @ 1.8Ghz) but at boot
 >   both 2.4.21-pre3 and 2.5.59 (obviously with a SMP kernel) tell me

I'd be surprised^Wamazed if your laptop has HT. AFAIK, no-one is
shipping such a system yet. Just because the CPU flags say 'ht' does
not mean it has >1 CPU thread per CPU package.

 >  "Dell Latitude with broken BIOS detected. Refusing to enable the local APIC."

Lots of Dell laptops (like other vendors) crash instantly when trying to
enable the APIC.

 >  Is this anything that can be played with ?

Nope.

		Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
