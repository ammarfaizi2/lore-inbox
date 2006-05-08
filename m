Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751145AbWEHVuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751145AbWEHVuX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 17:50:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWEHVuX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 17:50:23 -0400
Received: from gate.in-addr.de ([212.8.193.158]:11431 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S1751145AbWEHVuW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 17:50:22 -0400
Date: Mon, 8 May 2006 23:51:36 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Circuitsoft Development <circuitsoft.devel@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Fwd: Fwd: Extended Volume Manager API
Message-ID: <20060508215136.GQ5856@marowsky-bree.de>
References: <64b292120604302226i377f1c37qd33db36693ea1871@mail.gmail.com> <200605010702.k4172Q5H006348@turing-police.cc.vt.edu> <64b292120605010759h4d9c74d7s717d125018ab95d3@mail.gmail.com> <64b292120605011310n59ac3bdew2508bfa8b923adb3@mail.gmail.com> <Pine.LNX.4.64.0605020842250.29285@cuia.boston.redhat.com> <64b292120605062123gdb302d2g201fa59e93bc6a25@mail.gmail.com> <64b292120605081417y1684cba4kfb85ce39c14df0f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64b292120605081417y1684cba4kfb85ce39c14df0f7@mail.gmail.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-05-08T16:17:07, Circuitsoft Development <circuitsoft.devel@gmail.com> wrote:

> I'm not. They also need to get permission from the network before they
> write to the disk, and they're not going to get permission without
> hearing back from everybody. Besides, since the same network is used
> to connect to the disks as is used to connect the computers to each
> other, how would it be able to access the disks without being able to
> access other computers which also connect to the disks?

You really should read up about split-brain scenarios, quorum, IO
fencing, cluster membership algorithms and the amazing variety of
different types of crashes.


Sincerely,
    Lars Marowsky-Brée

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

