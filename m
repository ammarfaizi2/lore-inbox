Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262481AbUKQSK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262481AbUKQSK6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 13:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262488AbUKQSKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 13:10:55 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:18089 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262481AbUKQSJS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 13:09:18 -0500
Date: Wed, 17 Nov 2004 19:09:13 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Nikita Danilov <nikita@clusterfs.com>
cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [Request for inclusion] Filesystem in Userspace
In-Reply-To: <16795.37202.793499.93514@gargle.gargle.HOWL>
Message-ID: <Pine.LNX.4.53.0411171908260.29426@yvahk01.tjqt.qr>
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu>
 <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org> <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu>
 <84144f0204111602136a9bbded@mail.gmail.com> <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu>
 <20041116120226.A27354@pauline.vellum.cz> <E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu>
 <20041116163314.GA6264@kroah.com> <E1CURx6-0005Qf-00@dorka.pomaz.szeredi.hu>
 <16795.33515.187015.492860@thebsh.namesys.com> <Pine.LNX.4.53.0411171809490.24190@yvahk01.tjqt.qr>
 <16795.35688.634029.21478@gargle.gargle.HOWL> <Pine.LNX.4.53.0411171837250.15704@yvahk01.tjqt.qr>
 <16795.37202.793499.93514@gargle.gargle.HOWL>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Unless, of course, by "polluted" you mean that output of "cat
>/proc/self/mounts" becomes longer.

Precisely that. I recall there once was "you're exceeding the maximum number of
filesystems" or such, has that "bug"/"non-feature" been lifted?



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
