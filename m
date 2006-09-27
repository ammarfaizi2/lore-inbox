Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWI0Mby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWI0Mby (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 08:31:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932273AbWI0Mby
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 08:31:54 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:52095 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932245AbWI0Mbx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 08:31:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=I8Z7XQDCdL3IgHWK258qMCxRfFgVI/EOoqOysmJsDivqBobXqSRrIdq9hru2VHlKabJPD9RO1/wdjL4giqDcQHPWf8sU0k8CRk2kIVQlFUfingedzdvy7uiudUEvycF15H7h6wubSFgjYfl8PBv6cLsGY+Q/8x6N2WSYQo60fjk=
Message-ID: <5a4c581d0609270531p52d9452fie223dbd3152bcd38@mail.gmail.com>
Date: Wed, 27 Sep 2006 12:31:52 +0000
From: "Alessandro Suardi" <alessandro.suardi@gmail.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>
Subject: 2.6.18-git7 freezes solid on boot
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dell D610 running FC5, works fine with -git5, locks up
 in less than a second after selecting the GRUB entry
 for -git7, with NumLock on and nothing else working,
 SysRq included, except for the power switch (no need
 to keep it down for 10 secs though - it powers off
 right away).

Since bzdiffing patch-2.6.18-git5 and -git7 shows there
 are framebuffer changes, I'm wondering whether anyone
 had already stumbled into similar issues.

Video card is an Intel i915GM.

Thanks in advance, ciao,

--alessandro

"Well a man has two reasons for things that he does
  the first one is pride and the second one is love
  all understandings must come by this way"

     (Husker Du, 'She Floated Away')
