Return-Path: <linux-kernel-owner+w=401wt.eu-S1762913AbWLKNeM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762913AbWLKNeM (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 08:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762914AbWLKNeL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 08:34:11 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:60104 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762911AbWLKNeK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 08:34:10 -0500
Date: Mon, 11 Dec 2006 13:33:53 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: John Richard Moser <nigelenki@comcast.net>, linux-kernel@vger.kernel.org
Message-ID: <20061211133352.GA21359@srcf.ucam.org>
References: <200612102347_MC3-1-D49B-AB98@compuserve.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612102347_MC3-1-D49B-AB98@compuserve.com>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
Subject: Re: PAE/NX without performance drain?
X-SA-Exim-Version: 4.2.1 (built Tue, 20 Jun 2006 01:35:45 +0000)
X-SA-Exim-Scanned: Yes (on vavatch.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 10, 2006 at 11:46:44PM -0500, Chuck Ebbert wrote:

> If your hardware can run the x86_64 kernel, try using that with your
> i386 userspace.  It works here...

Losing vm86() support can cause problems.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
