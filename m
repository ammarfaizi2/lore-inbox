Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbWAZRzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbWAZRzN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 12:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751347AbWAZRzN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 12:55:13 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:41221 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S1751349AbWAZRzL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 12:55:11 -0500
Date: Thu, 26 Jan 2006 18:55:07 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <20060126175506.GA32972@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com> <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com> <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner> <20060126161028.GA8099@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060126161028.GA8099@suse.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2006 at 05:10:28PM +0100, Vojtech Pavlik wrote:
> I believe that if you added Linux 2.6 support code in libscg/cdrecord,
> that'd simply accept the device name as an argument and didn't use *any*
> scanning code at all, you'd make a lot of people happy (*). Quite possibly
> everyone minus one man. Which would be a great achievement.

Since Jens does not seem available anymore do you know how one is
supposed to do the cdrom-ish device enumeration at that point?  Is HAL
the official kernel interface to that now?

  OG.
