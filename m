Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbTLOVE4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Dec 2003 16:04:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263969AbTLOVE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Dec 2003 16:04:56 -0500
Received: from pop.gmx.net ([213.165.64.20]:33941 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S263953AbTLOVEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Dec 2003 16:04:55 -0500
X-Authenticated: #4512188
Message-ID: <3FDE21EF.6070608@gmx.de>
Date: Mon, 15 Dec 2003 22:04:47 +0100
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [OT] Exists? kernel/library simulating cluster/multi-processor machine
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

for my diploma I am currently working on a library called "load 
balancing class" originally developed by Frank Meisgen. As the name 
suggests its duty is to balance the load on a heterogenous cluster. The 
original library was written for sun sparc machines and I am proting it 
and enhancing it. Though I have started doing it for Windows2000, it 
also runs on Linux (which is the goal, but as Windows seems to make more 
troubles, I develop it there). A age simulation /population simulation 
already works and now I am busy debugging a fast sat solver (originally 
written by Max Böhm for his "plb" and converted to lbc by Frank Meisgen).

My question is, where there existes some sort of modified kernel or 
library (perhaps a modified mpi libraray, as lbc uses mpi to 
communicate) which simulates a cluster or multi-processor machines on a 
single cpu machine (or a "bigger" cluster on a cluster). Why? Of course 
it won't do anything good performance wise, But I want to see how well 
the lbc works and getting access to big clusters isn't easy esp if you 
want to tweak. Starting more than one process on one machine won't help, 
as the processes with natrurally balance each other.

Thanks,

Prakash
