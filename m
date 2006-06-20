Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbWFTQTj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbWFTQTj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 12:19:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbWFTQTj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 12:19:39 -0400
Received: from mail.mazunetworks.com ([4.19.249.111]:43655 "EHLO
	mail.mazunetworks.com") by vger.kernel.org with ESMTP
	id S1751391AbWFTQTj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 12:19:39 -0400
Message-ID: <44982033.9030507@mazunetworks.com>
Date: Tue, 20 Jun 2006 12:20:03 -0400
From: Jeff Gold <jgold@mazunetworks.com>
User-Agent: Mozilla Thunderbird 1.0.8-1.1.fc4 (X11/20060501)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Helge Hafting <helge.hafting@aitel.hist.no>
CC: Mark Lord <lkml@rtr.ca>, linux-kernel@vger.kernel.org
Subject: Re: Serial Console and Slow SCSI Disk Access?
References: <448DDC7F.4030308@mazunetworks.com> <448DDF1D.5020108@rtr.ca> <448DE4F1.9000407@mazunetworks.com> <4496492A.1030907@aitel.hist.no> <4496BF65.30108@mazunetworks.com> <44979F99.1090807@aitel.hist.no>
In-Reply-To: <44979F99.1090807@aitel.hist.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Helge Hafting wrote:
> I can see one possibility, that I didn't think of yesterday.
> Do the scsi host adapter share its interrupt with the serial line?

That makes a lot of sense.  I'll check it out and follow your 
instructions as soon as I can.  Thanks.

                                      Jeff
