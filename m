Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262040AbTLPS70 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Dec 2003 13:59:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262052AbTLPS70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Dec 2003 13:59:26 -0500
Received: from main.gmane.org ([80.91.224.249]:27616 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262040AbTLPS7Z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Dec 2003 13:59:25 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Wes Felter" <wesley@felter.org>
Subject: Re: [OT] Exists? kernel/library simulating cluster/multi-processor machine
Date: Tue, 16 Dec 2003 12:59:22 -0600
Message-ID: <pan.2003.12.16.18.59.22.896206@felter.org>
References: <3FDE21EF.6070608@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Pan/0.13.3 (That cat's something I can't explain)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Dec 2003 22:04:47 +0100, Prakash K. Cheemplavam wrote:

> My question is, where there existes some sort of modified kernel or 
> library (perhaps a modified mpi libraray, as lbc uses mpi to 
> communicate) which simulates a cluster or multi-processor machines on a 
> single cpu machine (or a "bigger" cluster on a cluster). Why? Of course 
> it won't do anything good performance wise, But I want to see how well 
> the lbc works and getting access to big clusters isn't easy esp if you 
> want to tweak. Starting more than one process on one machine won't help, 
> as the processes with natrurally balance each other.

Try User Mode Linux or Xen.

http://user-mode-linux.sourceforge.net/
http://www.cl.cam.ac.uk/Research/SRG/netos/xen/

-- 
Wes Felter - wesley@felter.org - http://felter.org/wesley/


