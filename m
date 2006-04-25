Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbWDYUh3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbWDYUh3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 16:37:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWDYUh3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 16:37:29 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:5310 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S932299AbWDYUh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 16:37:29 -0400
Date: Tue, 25 Apr 2006 21:37:24 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: dtor_core@ameritech.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Telling the kernel that keys need soft release?
Message-ID: <20060425203724.GA29246@srcf.ucam.org>
References: <20060425202526.GA29169@srcf.ucam.org> <d120d5000604251333s7ee66f22h6ee92189233790ea@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d120d5000604251333s7ee66f22h6ee92189233790ea@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 04:33:57PM -0400, Dmitry Torokhov wrote:

> Yes, with a proper DMI entry to activate it would be very welcome.

I was thinking more along the lines of extending the setkeycodes support 
to allow a flag to specify it from userspace, though I guess adding some 
kernel defaults wouldn't hurt.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
