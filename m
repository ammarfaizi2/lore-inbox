Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266270AbSLCLp6>; Tue, 3 Dec 2002 06:45:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266271AbSLCLp6>; Tue, 3 Dec 2002 06:45:58 -0500
Received: from kiruna.synopsys.com ([204.176.20.18]:33274 "HELO
	kiruna.synopsys.com") by vger.kernel.org with SMTP
	id <S266270AbSLCLp5>; Tue, 3 Dec 2002 06:45:57 -0500
Date: Tue, 3 Dec 2002 12:49:38 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: mingo@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: world read permissions on /proc/irq/prof_cpu_mask and ...smp_affinity
Message-ID: <20021203114938.GD26745@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Is there any reason to set the permissions to 0600?
It makes the admin to login as root just to look on the
current system state.
Is there something against 0644?

-alex
