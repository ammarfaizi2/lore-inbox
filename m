Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262063AbULPWne@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262063AbULPWne (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Dec 2004 17:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262058AbULPWnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Dec 2004 17:43:33 -0500
Received: from h-66-134-106-242.mclnva23.covad.net ([66.134.106.242]:56840
	"EHLO lapsony.mydomain.here") by vger.kernel.org with ESMTP
	id S262053AbULPWmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Dec 2004 17:42:14 -0500
From: "Steven A. DuChene" <sduchene@mindspring.com>
Date: Thu, 16 Dec 2004 14:10:18 -0500
To: linux-kernel@vger.kernel.org
Subject: all three IO Schedulers turned on in 2.6.10-rc3-mm1 ???
Message-ID: <20041216141018.D927@lapsony.sc04.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I downloaded and built the 2.6.10-rc3-mm1 kernel and I noticed while
configuring it that in the Device Drivers > Block devices > IO Schedulers
area that by default all three IO Schedulers are turned on. Is this a
normal condition or is there only supposed to be one of these turned on?

The reason I am concerned about this is that ever since I have booted
into this kernel I have a lot of things failing and when they fail
they return a message like "Inappropriate ioctl for device"

I get this when trying to do a simple wget (remote address fails to resolve)
and when trying to run any X program against the Xserver running on the system.
-- 
Steven A. DuChene	linux-clusters . AT . mindspring . DOT . com
