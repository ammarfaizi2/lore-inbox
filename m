Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261209AbTIDXeq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 19:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbTIDXep
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 19:34:45 -0400
Received: from fep04-svc.mail.telepac.pt ([194.65.5.203]:13283 "EHLO
	fep04-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id S261209AbTIDXeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 19:34:44 -0400
Message-ID: <3F57CC2E.2030708@vgertech.com>
Date: Fri, 05 Sep 2003 00:35:10 +0100
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030714 Debian/1.4-2
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Wes Felter <wesley@felter.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Remote SCSI Emulation
References: <LAW11-F717fcGuKeddZ000021c9@hotmail.com> <pan.2003.09.03.22.59.26.698967@felter.org>
In-Reply-To: <pan.2003.09.03.22.59.26.698967@felter.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Wes Felter wrote:
> On Wed, 03 Sep 2003 20:38:14 +0000, Muthian S wrote:
> 
> 
>>Certain SCSI adapters like the Adaptec AHA 29160 are reportedly capable of
>>acting as a target and can receive SCSI commands from initiators.  Such an
>>adapter can be used to facilitate remote SCSI emulation by a PC.
>>For instance, if two PCs have the adapter, the two adapters can be
>>directly connected by a SCSI bus and the second PC can in effect serve as
>>an "emulated SCSI disk".  Such a setup is extremely helpful in various
>>scenarios.
> 
> 
> Search the archives/Web for "SCSI target", "LinuxDisk", etc. There are
> plenty of half-finished implementations of this.
> 

Another, more generic, solution is "ip over scsi":

http://www.google.com/search?q=%22ip+over+scsi%22

Regards,
Nuno Silva


