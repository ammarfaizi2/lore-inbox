Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315204AbSGMQvA>; Sat, 13 Jul 2002 12:51:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315207AbSGMQu7>; Sat, 13 Jul 2002 12:50:59 -0400
Received: from pcp809445pcs.nrockv01.md.comcast.net ([68.49.82.129]:58265 "EHLO
	zalem.puupuu.org") by vger.kernel.org with ESMTP id <S315204AbSGMQu7>;
	Sat, 13 Jul 2002 12:50:59 -0400
Date: Sat, 13 Jul 2002 12:53:46 -0400
From: Olivier Galibert <galibert@pobox.com>
To: Erik Andersen <andersen@codepoet.org>, linux-kernel@vger.kernel.org
Subject: Re: IDE/ATAPI in 2.5
Message-ID: <20020713125346.B10051@zalem.puupuu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Erik Andersen <andersen@codepoet.org>, linux-kernel@vger.kernel.org
References: <200207121955.g6CJtQur018433@burner.fokus.gmd.de> <20020713054058.GA19292@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020713054058.GA19292@codepoet.org>; from andersen@codepoet.org on Fri, Jul 12, 2002 at 11:40:58PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2002 at 11:40:58PM -0600, Erik Andersen wrote:
> If you would throw away crdrecord's desire to do its own private
> SCSI bus scanning

CDROM_SEND_PACKET sounds nice, but do you have a way to:
1- Find all cdrom-ish devices in the system
2- Find if a given device is cdrom-ish

By cdrom-ish, I mean cdrom, dvdrom, cd writer, dvd writer or a
combination.

Point 1 is necessary to be a minimum user-friendly, point 2 is
necessary because you can't trust users :-)

  OG.

