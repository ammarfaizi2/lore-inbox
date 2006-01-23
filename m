Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWAWNuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWAWNuY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 08:50:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbWAWNuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 08:50:24 -0500
Received: from wproxy.gmail.com ([64.233.184.198]:54363 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751407AbWAWNuX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 08:50:23 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Nn/KIqAe8QU6eyvQlK08x+XgafOVIVPhztiQ2Pd8UL2e/m6JToffIEPTt/BTVGpuyRrfgPCnEed7LHnCEVfwYPeLa1rUxSUrYgy6AlFECm5dQqgm2dsbBuk4BRhtteqQioii0MApFAi7TbG91swkGerXdXVEQcjF+p66g+QbFC8=
Message-ID: <6bffcb0e0601230521l59b8360et@mail.gmail.com>
Date: Mon, 23 Jan 2006 14:21:48 +0100
From: Michal Piotrowski <michal.k.k.piotrowski@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: 2.6.15-rt12 bugs
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have noticed some bugs in latest 2.6.15-rt12, here are some of them:
http://www.stardust.webpages.pl/files/rt/2.6.15-rt12/rt-dmesg
Here is my config:
http://www.stardust.webpages.pl/files/rt/2.6.15-rt12/rt-config

Regards,
Michal Piotrowski
