Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262014AbVANQ4d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262014AbVANQ4d (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 11:56:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbVANQ4d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 11:56:33 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33215 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262014AbVANQ41 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 11:56:27 -0500
Date: Fri, 14 Jan 2005 11:56:12 -0500
From: Dave Jones <davej@redhat.com>
To: "Barry K. Nathan" <barryn@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc1-mm1
Message-ID: <20050114165612.GB19208@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	"Barry K. Nathan" <barryn@pobox.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <20050114002352.5a038710.akpm@osdl.org> <20050114150714.GA4501@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050114150714.GA4501@ip68-4-98-123.oc.oc.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2005 at 07:07:14AM -0800, Barry K. Nathan wrote:
 > This isn't new to 2.6.11-rc1-mm1, but it has the infamous (to Fedora
 > users) "ACPI shutdown bug" -- poweroff hangs instead of actually turning
 > the computer off, on some computers. Here's the RH Bugzilla report where
 > most of the discussion took place:
 > 
 > https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=132761                     
 > 
 > In the Fedora kernels it turned out to be due to kexec. I'll see if I
 > can narrow it down further.

For *some* users. It still affects others.
My Compaq Evo showed the bug with 2.6.9 vanilla, went away with 2.6.10
vanilla.

		Dave

