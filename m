Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310396AbSCBPqu>; Sat, 2 Mar 2002 10:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310397AbSCBPqk>; Sat, 2 Mar 2002 10:46:40 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:18670 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S310396AbSCBPqV>; Sat, 2 Mar 2002 10:46:21 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <3C7FEA0A.250D71DB@cotw.com> 
In-Reply-To: <3C7FEA0A.250D71DB@cotw.com> 
To: Scott A McConnell <samcconn@cotw.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fs/Config.in :Simple patch to require CONFIG_PROC_FS before CONFIG_JFFS_PROC_FS is available. 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 02 Mar 2002 15:45:52 +0000
Message-ID: <9106.1015083952@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That was left out for a reason. CONFIG_REISERFS_PROC_INFO leaves it out for 
the same reason. You didn't bother to test this, did you?

--
dwmw2


