Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261890AbVBAJio@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261890AbVBAJio (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 04:38:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261933AbVBAJio
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 04:38:44 -0500
Received: from wproxy.gmail.com ([64.233.184.201]:28058 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261890AbVBAJin (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 04:38:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=hnvgItrg4d8X84OEayTu4eGUichfDZ+DzgCA6Jn53XhBt4K1kwgcS5TDUm8QE0jAG/9eI8cYIDMCRVj5RFQIn7kHeoKKiCbVFcC+OdBKsrnDetTl35ka0RLF+joE56HCRJesOHb51qeQsIF9UoBDLB36S/BZXMWkgcWqcfKAm9I=
Message-ID: <5a3ed565050201013811b8e3e1@mail.gmail.com>
Date: Tue, 1 Feb 2005 12:38:42 +0300
From: regatta <regatta@gmail.com>
Reply-To: regatta <regatta@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: How to do a complete poweroff ?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

In my workstation when I execute a poweroff command it will shutdown
the system and power off the machine

but when I do it in a rack-mounted server (with the same kernel
"2.4.*") it only will halt the machine ?

Anyone know what is the differrent ? I don't have an issue with that
but I want to learn why is that


-- 
Best Regards,
--------------------
-*- If Linux doesn't have the solution, you have the wrong problem -*-
