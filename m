Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265388AbSJRTGo>; Fri, 18 Oct 2002 15:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265385AbSJRTFO>; Fri, 18 Oct 2002 15:05:14 -0400
Received: from citi.umich.edu ([141.211.92.141]:26120 "HELO citi.umich.edu")
	by vger.kernel.org with SMTP id <S265388AbSJRTFA>;
	Fri, 18 Oct 2002 15:05:00 -0400
Date: Fri, 18 Oct 2002 15:10:57 -0400
From: Niels Provos <provos@citi.umich.edu>
To: linux-kernel@vger.kernel.org
Cc: marius@umich.edu
Subject: systrace for linux
Message-ID: <20021018191057.GJ1704@citi.citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Marius A. Eriksen just finished the Linux port of systrace.  You can
find the kernel patch at

  http://www.citi.umich.edu/u/provos/systrace/linux.html

Systrace is a fine grained sandbox for applications and system services.
It supports interactive policy generation, intrusion detection, policy
enforcement, privilege elevation, etc.  More information at

  http://www.citi.umich.edu/u/provos/systrace/

Comments are appreciated.

Niels.
