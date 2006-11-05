Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161177AbWKEG5L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161177AbWKEG5L (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Nov 2006 01:57:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161179AbWKEG5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Nov 2006 01:57:11 -0500
Received: from wx-out-0506.google.com ([66.249.82.239]:54702 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161177AbWKEG5J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Nov 2006 01:57:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=fwB6qRM75gmgXEUtryIKHMq8nQz43KT+PpQGT3v7mJMsZr1mGYU1Irdh7O0+3dtBX63H2R38cySrZfpnA11msvDCuPgD8CmTjWqbvw2xa6X6T4qpb1Z7IZRALtL42iVEeVAvE5NAHeG7tu21HrzfAvRsELf0Un919tArBUyTHr0=
Message-ID: <2ac89c700611042257p6c4ea9cdsdfb7b2d3f2415d8a@mail.gmail.com>
Date: Sun, 5 Nov 2006 08:57:09 +0200
From: "Dmitry Bohush" <dmitrij.bogush@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: High pitch noise on Acer Aspire 5602WLMi
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,  Probably it is one of resistors on motherboard. This noise
goes away with adding acpi=off to boot params.

What is this? It can be fixed?


-- 
Best Regards,
Dmitry A Bohush.

//FRWL00{$n}
