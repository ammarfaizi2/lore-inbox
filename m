Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266324AbUAVRRF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 12:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266325AbUAVRRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 12:17:05 -0500
Received: from dsl-213-023-011-163.arcor-ip.net ([213.23.11.163]:3799 "EHLO
	fusebox.fsfeurope.org") by vger.kernel.org with ESMTP
	id S266324AbUAVRRA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 12:17:00 -0500
To: Karol Kozimor <sziwan@hell.org.pl>
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ACPI] PROBLEM: LCD display dead after ACPI suspend to RAM (S3)
References: <m3hdyo2kce.fsf@reason.gnu-hamburg>
	<20040122140155.GC5194@hell.org.pl>
	<m3d69cj8hb.fsf@reason.gnu-hamburg>
	<20040122154638.GA11867@hell.org.pl>
From: "Georg C. F. Greve" <greve@gnu.org>
Organisation: Free Software Foundation Europe - GNU Project
X-PGP-Fingerprint: 2D68 D553 70E5 CCF9 75F4 9CC9 6EF8 AFC2 8657 4ACA
X-PGP-Affinity: will accept encrypted messages for GNU Privacy Guard
X-Home-Page: http://gnuhh.org
X-Accept-Language: en, de
Date: Thu, 22 Jan 2004 18:16:44 +0100
In-Reply-To: <20040122154638.GA11867@hell.org.pl> (Karol Kozimor's message
 of "Thu, 22 Jan 2004 16:46:38 +0100")
Message-ID: <m365f3dhtv.fsf@reason.gnu-hamburg>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 || On Thu, 22 Jan 2004 16:46:38 +0100
 || Karol Kozimor <sziwan@hell.org.pl> wrote: 

 kk> Does it work before the suspend (i.e. does the backlight switch
 kk> on and off)? 

Yes.


 kk> If so, your problem is probably a video driver issue and I'm
 kk> afraid I can't be of further help.

Where would the people maintaining the video driver have to look?


 kk> Also, are you using a framebuffer? 

Yes.


 kk> If so, try not, i.e. use a simple VGA console -> s3_bios works
 kk> fine for me on a VGA console, but produces a blank (though
 kk> backlit) screen with radeonfb.  Best regards,

Interesting. I'll try that.

May this be a problem of the fb driver then?

Thanks for your input,
Georg

-- 
Georg C. F. Greve                                       <greve@gnu.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)
