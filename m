Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbUJYNeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbUJYNeT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 09:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261800AbUJYNcH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 09:32:07 -0400
Received: from smtp01.symbian.com ([206.165.101.41]:17683 "EHLO
	smtp01.symbian.com") by vger.kernel.org with ESMTP id S261799AbUJYNaz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 09:30:55 -0400
Message-ID: <417CFFDE.3070904@symbian.com>
Date: Mon, 25 Oct 2004 14:30:06 +0100
From: Johan Groth <johan.groth@symbian.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: External USB harddisk problems
X-MIMETrack: Itemize by SMTP Server on SymbianUK03/Symbian(651HF487|August 12, 2004) at
 25/10/2004 14:30:07,
	Serialize by Router on LONMAILHUB02/LON/H/Symbian(Release 6.5|September 18, 2003) at
 25/10/2004 14:28:26,
	Serialize complete at 25/10/2004 14:28:26
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="us-ascii";
	format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm experiencing problems with a Maxtor USB HD drives that hope someone 
on this list can shed some light on. When I try to copy a file to or 
from the HD that is > 100MB the whole system hangs. I can't ping it from 
another systems, nothing shows up in any logs so I don't know why it 
hangs. I'm using 2.6.8-k7-smp from Debian unstable. The USB card is a 
2.0 version with a Nec chipset.

Regards,
Johan

PS, please CC me as I'm not subscribed to this list.



-----------------------------------------
Symbian Software Ltd is a company registered in England and Wales with
registered number 4190020 and registered office at 2-6 Boundary Row,
Southwark, London, SE1 8HP, UK. This message is intended only for use by
the named addressee and may contain privileged and/or confidential
information. If you are not the named addressee you should not disseminate,
copy or take any action in reliance on it. If you have received this
message in error please notify postmaster@symbian.com and delete the
message and any attachments accompanying it immediately. Neither Symbian
nor any of its subsidiaries accepts liability for any corruption,
interception, amendment, tampering or viruses occurring to this message in
transit or for any message sent by its employees which is not in compliance
with Symbian corporate policy.

