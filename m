Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWAZKkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWAZKkY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 05:40:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932288AbWAZKkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 05:40:24 -0500
Received: from mail.gmx.de ([213.165.64.21]:34536 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932286AbWAZKkX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 05:40:23 -0500
X-Authenticated: #428038
Date: Thu, 26 Jan 2006 11:40:12 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: mrmacman_g4@mac.com, rlrevell@joe-job.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060126104012.GA32206@merlin.emma.line.org>
Mail-Followup-To: Joerg Schilling <schilling@fokus.fraunhofer.de>,
	mrmacman_g4@mac.com, rlrevell@joe-job.com,
	linux-kernel@vger.kernel.org, acahalan@gmail.com
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com> <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com> <43D7B1E7.nailDFJ9MUZ5G@burner> <C3FAC4ED-D7B6-45FE-BCC8-DDCE1E8EEC65@mac.com> <43D89F23.nailDTH5ZT0IY@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43D89F23.nailDTH5ZT0IY@burner>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joerg Schilling schrieb am 2006-01-26:

> Even with /dev/scg* on Solaris or with CAM on FreeBSD, you open a device.
> But this is not a /dev/ entry for a high level device like a disk, it is 
> a SCSI nexus device that allows you to send SCSI commands on any SCSI
> transport.

As long as the device you open allows you to send SCSI commands on any
suitable (not just SCSI) transport, why bother?

-- 
Matthias Andree
