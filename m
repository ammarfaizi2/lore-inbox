Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030389AbWJCVZL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030389AbWJCVZL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 17:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030561AbWJCVZK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 17:25:10 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:44196 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030389AbWJCVZJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 17:25:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=SQ6mcUgJj3qGurQ7H1dnHcP8HRoEwTdLBUarfa3i4XebOaUFSBZ6tpQ7IyNY6uURG7X/IVcNElj1mf6JGEi/PJmC4TWOV5/LgNBLZJ8W9xNm6LDlBbUlI9nJB9taR67ALH7BGgs+tEv99hISyx4+kA5nQt1fw2/xmIz1ZoXU388=
Message-ID: <1df1788c0610031425p4f1ca206teb05590a91eb7659@mail.gmail.com>
Date: Tue, 3 Oct 2006 18:25:07 -0300
From: "=?ISO-8859-1?Q?Br=E1ulio_Oliveira?=" <brauliobo@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Fwd: Registration Weakness in Linux Kernel's Binary formats
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just forwarding....

---------- Forwarded message ----------
From: SHELLCODE Security Research <GoodFellas@shellcode.com.ar>
Date: Oct 3, 2006 4:13 PM
Subject: Registration Weakness in Linux Kernel's Binary formats
To: undisclosed-recipients


Hello,
The present document aims to demonstrate a design weakness found in the
handling of simply
linked   lists   used   to   register   binary   formats   handled   by
Linux   kernel,   and   affects   all   the   kernel families
(2.0/2.2/2.4/2.6), allowing the insertion of infection modules in
kernel­ space that can be used by malicious users to create infection
tools, for example rootkits.

POC, details and proposed solution at:
English version: http://www.shellcode.com.ar/docz/binfmt-en.pdf
Spanish version: http://www.shellcode.com.ar/docz/binfmt-es.pdf

regards,
--
SHELLCODE Security Research TEAM
GoodFellas@shellcode.com.ar
http://www.shellcode.com.ar


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
