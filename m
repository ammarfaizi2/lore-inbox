Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932188AbWDPDqS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932188AbWDPDqS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 23:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWDPDqS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 23:46:18 -0400
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:21775 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932188AbWDPDqS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 23:46:18 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: HP Pavilion dv5320us, amd64 'turion' cpu
Date: Sun, 16 Apr 2006 04:46:18 +0100
User-Agent: KMail/1.9.1
Cc: Gene Heskett <gene.heskett@verizon.net>
References: <200604151457.12508.gene.heskett@verizon.net>
In-Reply-To: <200604151457.12508.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604160446.18861.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 15 April 2006 19:57, Gene Heskett wrote:
> Greetings;
>
> I've been dl'ing and burning cd's and dvd's at a furious rate for
> several days now, looking for a 64 bit distribution that will actually
> boot on this thing, apparently in vain.  i386 stuff works fine.
> The kubuntu 'breezy' 5.10 locks up at the ACPI line regardless of what
> kernel options you pass trying to disable it.

If you really can't get it working, building an AMD64 cross compiler and an 
AMD64 kernel on a 32bit only distribution is surprisingly easy. It would 
allow you to debug any 64bit specific problems whilst allowing you to fall 
back on the comforts of a working kernel..

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
