Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932265AbVHRPoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932265AbVHRPoZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Aug 2005 11:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932270AbVHRPoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Aug 2005 11:44:25 -0400
Received: from wproxy.gmail.com ([64.233.184.193]:1707 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932265AbVHRPoY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Aug 2005 11:44:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=AqOBMemfLKk9aKHVImP68hCoJkwLPnfuLHaxBKDADlaVCuQupC8c8LipCDn5a7gr4qaYszX0K4aobWkE5OUBH4y9GUsPukUNx7BdQxKM40jsAocRoaz6mXgPiDkRom0JECiAjNe6S6+ykuos6r5YSkp0qGdbxbL0Aalad04yj5U=
Message-ID: <4fec73ca050818084467f04c31@mail.gmail.com>
Date: Thu, 18 Aug 2005 17:44:19 +0200
From: =?ISO-8859-1?Q?Guillermo_L=F3pez_Alejos?= <glalejos@gmail.com>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Environment variables inside the kernel?
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a piece of code which uses environment variables. I have been
told that it is not going to work in kernel space because the concept
of environment is not applicable inside the kernel.

I belive that, but I need to demonstrate it. I do not know how to
proof this, perhaps referring to a solid reference about Linux design
that points to the idea that it has no sense to use environment
variables in kernel space.

Do anyone knows about the existence of such document?

Thank you,

-- 
Guillermo
