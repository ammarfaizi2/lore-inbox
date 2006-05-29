Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750706AbWE2MOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWE2MOv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 May 2006 08:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWE2MOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 May 2006 08:14:51 -0400
Received: from wr-out-0506.google.com ([64.233.184.239]:61637 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1750706AbWE2MOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 May 2006 08:14:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=FztgaFQCR6rvkqFqVbq8Vtw9kutEdkuKeIiZkrhsGUAb46Mv9p3O5rj/0qTBxDUmjb7L8AIf0w2YBX7QfTGGrQwobo1daqGNxMc9vRwASV6g57oLGM7jriCgT37U8LobDT6C8UjB2RkAfNWzniGh3uH1e1HCPNtI4D0EaZ/rM/I=
Message-ID: <331433e10605290514k7b1d0b3if6fdb5a74eeccf47@mail.gmail.com>
Date: Mon, 29 May 2006 13:14:47 +0100
From: "tom hall" <thattommyhall@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: External SATA, can a linux box appear as a device? Any other ideas for box as direct attached storage?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

eSATA is new to me, ive never used it.
im guessing a linux box makes a good host for a eSATA device, but i
was wondering if it can appear as a device to other computers.
Ive just built myself a NAS box and as some of them have a way to
directly attach to one computer, i would like mine to as well. it is
not possible via usb without buying a different controller as all in
standard PCs are hosts.
Can i do it with firewire (appear as a attached device)? or is IP over
firewire the only way to do it?
ive searched the net for this, hope you can help
tom
