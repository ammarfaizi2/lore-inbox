Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261646AbVF1Qmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261646AbVF1Qmn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 12:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbVF1Qmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 12:42:43 -0400
Received: from main.gmane.org ([80.91.229.2]:24785 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261646AbVF1Qml (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 12:42:41 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Giuseppe Bilotta <bilotta78@hotpop.com>
Subject: Re: Problems with Firewire and -mm kernels
Date: Tue, 28 Jun 2005 18:38:08 +0200
Message-ID: <qejwnthip8iq$.19x75g4s1punv.dlg@40tude.net>
References: <20050626040329.3849cf68.akpm@osdl.org> <42BE99C3.9080307@trex.wsi.edu.pl> <20050627025059.GC10920@ime.usp.br> <20050627164540.7ded07fc.akpm@osdl.org> <20050628010052.GA3947@ime.usp.br> <20050627202226.43ebd761.akpm@osdl.org> <42C0FF50.7080300@s5r6.in-berlin.de> <20050628004650.18282bd6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: adsl-ull-146-118.44-151.net24.it
User-Agent: 40tude_Dialog/2.0.15.1
Posted-And-Mailed: yes
Cc: linux1394-devel@lists.sourceforge.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jun 2005 00:46:50 -0700, Andrew Morton wrote:

> Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
>>
>>>  ieee1394: Node changed: 0-01:1023 -> 0-00:1023
>>  >  ieee1394: Node suspended: ID:BUS[0-00:1023]  GUID[0050c501e00010e8]
>> 
>>  What caused these two messages? Did you disconnect the drive at this point?
> 
> No, there is no device plugged into the machine.
> 
> Maybe the G5 has some internal 1394 device?  It would be news to me if so.

Well, I would assume the Macs play some trick with the internal 
Firewire and IDE/SCSI channels to allow the internal hard disk to come 
up as firewire hard disks for other Macs when in Target mode. So maybe 
that's the result of this?

-- 
Giuseppe "Oblomov" Bilotta

"Da grande lotterò per la pace"
"A me me la compra il mio babbo"
(Altan)
("When I grow up, I will fight for peace"
 "I'll have my daddy buy it for me")

