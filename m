Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264044AbVBDThC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264044AbVBDThC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 14:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263141AbVBDThC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 14:37:02 -0500
Received: from pirx.hexapodia.org ([199.199.212.25]:35650 "EHLO
	pirx.hexapodia.org") by vger.kernel.org with ESMTP id S264044AbVBDTgx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 14:36:53 -0500
Date: Fri, 4 Feb 2005 11:36:53 -0800
From: Andy Isaacson <adi@hexapodia.org>
To: Paulo Marques <pmarques@grupopie.com>
Cc: Ian Godin <Ian.Godin@lowrydigital.com>, linux-kernel@vger.kernel.org
Subject: Re: Drive performance bottleneck
Message-ID: <20050204193653.GB14940@hexapodia.org>
References: <c4fc982390674caa2eae4f252bf4fc78@lowrydigital.com> <42026207.4090007@vgertech.com> <ef0635f8b4257d18fad10882a2c79f64@lowrydigital.com> <42027594.9090402@grupopie.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42027594.9090402@grupopie.com>
User-Agent: Mutt/1.4.1i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 03, 2005 at 07:03:48PM +0000, Paulo Marques wrote:
> FYI there was a patch running around last April that made a new option 
> for "dd" to make it use O_DIRECT. You can get it here:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=108135935629589&w=2
> 
> Unfortunately this hasn't made it into coreutils.

Follow down the thread and you'll see that it was merged to coreutils
CVS (message-id <85k70qsp71.fsf@pi.meyering.net>), but there apparently
hasn't been a coreutils release since then.  Nor has the patch been
added to the debian package.

-andy
