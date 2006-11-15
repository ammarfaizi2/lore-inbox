Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932816AbWKOHWU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932816AbWKOHWU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932822AbWKOHWU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:22:20 -0500
Received: from py-out-1112.google.com ([64.233.166.182]:45673 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S932816AbWKOHWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:22:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=HpLB5HbExZo9Be61qhnaiwjV0Za2HMyk90hL7oPZ9wb3K4LhTRYge03Ak19MoparmoTACyq9LpWUcIUj+IqaPcGsSn3/OuHl0S6HwR45yEZNukrYpXEafmb06jxlX2gY730DKFNsRoLFHEsul++c04miuFgVFiDStfVQotiCgNA=
Message-ID: <53f38ab60611142322g5772121cw63484d2a4d241d71@mail.gmail.com>
Date: Tue, 14 Nov 2006 23:22:18 -0800
From: "adheer chandravanshi" <adheerchandravanshi@gmail.com>
To: kernelnewbies <kernelnewbies@nl.linux.org>
Subject: cross compilation ia32 to ia64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

I have downloaded the HP ski simulator and I want to run it on my ia32 machine.
For this I need to cross compile the kernel.
Though I tried the cross ciimpilation but did not succeed.

Can anyone please tell me from where can I get the pre-build binaries
and clear steps to cross compile for host=ia32 and target=ia64?

-Adheer
