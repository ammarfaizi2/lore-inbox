Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266032AbUAUWeD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 17:34:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266044AbUAUWeD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 17:34:03 -0500
Received: from dsl-213-023-011-163.arcor-ip.net ([213.23.11.163]:61839 "EHLO
	fusebox.fsfeurope.org") by vger.kernel.org with ESMTP
	id S266032AbUAUWeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 17:34:01 -0500
To: =?iso-8859-15?q?S=E9rgio_Monteiro_Basto?= <sergiomb@netcabo.pt>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       acpi-devel <acpi-devel@lists.sourceforge.net>
Subject: Re: [ACPI] Re: PROBLEM: ACPI freezes 2.6.1 on boot
References: <Pine.LNX.4.58.0401211051530.2123@home.osdl.org>
	<m3d69dhukz.fsf@reason.gnu-hamburg>
	<1074721887.3672.12.camel@darkstar.portugal>
From: "Georg C. F. Greve" <greve@gnu.org>
Organisation: Free Software Foundation Europe - GNU Project
X-PGP-Fingerprint: 2D68 D553 70E5 CCF9 75F4 9CC9 6EF8 AFC2 8657 4ACA
X-PGP-Affinity: will accept encrypted messages for GNU Privacy Guard
X-Home-Page: http://gnuhh.org
X-Accept-Language: en, de
Date: Wed, 21 Jan 2004 23:33:43 +0100
In-Reply-To: <1074721887.3672.12.camel@darkstar.portugal> 
 =?iso-8859-15?q?=28S=E9rgio?= Monteiro Basto's message of "21 Jan 2004 21:51:27 +0000")
Message-ID: <m34qupdj94.fsf@reason.gnu-hamburg>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 || On 21 Jan 2004 21:51:27 +0000
 || Sérgio Monteiro Basto <sergiomb@netcabo.pt> wrote: 

 smb> And disable apic (lopic and io-pic) options from kernel compilation ?

Funny -- we seemed to have had the same idea. 

Yes, this makes it boot (see my other mail).

Regards,
Georg

-- 
Georg C. F. Greve                                       <greve@gnu.org>
Free Software Foundation Europe	                 (http://fsfeurope.org)
Brave GNU World	                           (http://brave-gnu-world.org)
