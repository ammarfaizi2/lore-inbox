Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265368AbTLRWwi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 17:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265374AbTLRWwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 17:52:38 -0500
Received: from DELFT.AURA.CS.CMU.EDU ([128.2.206.88]:2693 "EHLO
	delft.aura.cs.cmu.edu") by vger.kernel.org with ESMTP
	id S265368AbTLRWwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 17:52:37 -0500
Date: Thu, 18 Dec 2003 17:52:36 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: Mount Rainier in 2.6
Message-ID: <20031218225236.GA27102@delft.aura.cs.cmu.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3FE16489.9060006@tiscali.cz> <20031218083530.GP2495@suse.de> <20031218114000.GB2069@suse.de> <3FE200CA.2080705@tiscali.cz> <20031218193414.GJ2069@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031218193414.GJ2069@suse.de>
User-Agent: Mutt/1.5.4i
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 18, 2003 at 08:34:14PM +0100, Jens Axboe wrote:
> On Thu, Dec 18 2003, Milos Prudek wrote:
> Rats, I forgot to test sr. You probably don't have a SCSI mt rainier
> drive (I doubt one was ever made), so just disable SCSI CD-ROM support.

Actually, external USB enclosures show up as SCSI even when they
internally have a regular IDE/ATAPI drive. Your original patches (early
2.5?) did work nicely with an external USB2.0 writer.

Jan
