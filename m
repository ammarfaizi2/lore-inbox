Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132845AbRBEFwF>; Mon, 5 Feb 2001 00:52:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132860AbRBEFvz>; Mon, 5 Feb 2001 00:51:55 -0500
Received: from gate.in-addr.de ([212.8.193.158]:5893 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S132845AbRBEFvl>;
	Mon, 5 Feb 2001 00:51:41 -0500
Date: Mon, 5 Feb 2001 06:50:29 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Rusty Russell <rusty@linuxcare.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Hot swap CPU support for 2.4.1
Message-ID: <20010205065029.K430@marowsky-bree.de>
In-Reply-To: <E14PcpU-0004U1-00@halfway>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.3i
In-Reply-To: <E14PcpU-0004U1-00@halfway>; from "Rusty Russell" on 2001-02-05T15:00:40
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2001-02-05T15:00:40,
   Rusty Russell <rusty@linuxcare.com.au> said:

> I did the infrastructure, Anton did the bugfinding and PPC support,
> aka. the hard stuff.  Other architectures need to implement
> __cpu_disable, __cpu_die and __cpu_up for them to work.  Volunteers
> appreciated.

Rusty, what would be needed to "hot-add" CPUs ?

Sincerely,
    Lars Marowsky-Brée <lars.marowsky-bree@sap.com>
    SuSE Linux AG at the SAP LinuxLab - lmb@suse.de

-- 
Perfection is our goal, excellence will be tolerated. -- J. Yahl

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
