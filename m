Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272152AbTHSFFc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 01:05:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275340AbTHSFFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 01:05:31 -0400
Received: from fep02-svc.mail.telepac.pt ([194.65.5.201]:53707 "EHLO
	fep02-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id S272152AbTHSFF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 01:05:27 -0400
Message-ID: <3F41AFC0.40704@vgertech.com>
Date: Tue, 19 Aug 2003 06:04:00 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: "Nayak, Samdeep" <Samdeep_Nayak@adaptec.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux SCSI benchmarking tool??
References: <E18F4A9ED285D41191FA00B0D0498DB90649D4E5@aimexc06.corp.adaptec.com>
In-Reply-To: <E18F4A9ED285D41191FA00B0D0498DB90649D4E5@aimexc06.corp.adaptec.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Nayak, Samdeep wrote:

[..snip..]

> I realized that I was writing to the buffer and not writing on the raw

The simple solutions is to boot with 16MB of RAM :)
Just append RAM=16M to linux's command line (in lilo...) and use large 
sets of data.

Regards,
Nuno Silva


