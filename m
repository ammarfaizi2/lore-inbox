Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbTIHOoG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 10:44:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262408AbTIHOoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 10:44:05 -0400
Received: from aneto.able.es ([212.97.163.22]:30855 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S262372AbTIHOoD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 10:44:03 -0400
Date: Mon, 8 Sep 2003 16:43:45 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Klaus Dittrich <kladit@t-online.de>
Cc: linux mailing-list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.23-pre3 hypertreading
Message-ID: <20030908144345.GA2560@werewolf.able.es>
References: <20030908142033.GA568@xeon2.local.here>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20030908142033.GA568@xeon2.local.here>; from kladit@t-online.de on Mon, Sep 08, 2003 at 16:20:33 +0200
X-Mailer: Balsa 2.0.14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 09.08, Klaus Dittrich wrote:
> Dual-Xeon board i7505, apic enabled.
> 
> With 2.4.23-pre3 the number of cpu's detected is two,
> with 2.4.22 the number of cpu's detected is four.
> 

Build with ACPI and ACPI CPU detection only ?

-- 
J.A. Magallon <jamagallon@able.es>      \            Software is like sex:
werewolf.able.es                         \      It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.23-pre2-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-1mdk))
