Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316213AbSFDEFj>; Tue, 4 Jun 2002 00:05:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316214AbSFDEFi>; Tue, 4 Jun 2002 00:05:38 -0400
Received: from pcp809261pcs.nrockv01.md.comcast.net ([68.49.81.201]:17024 "EHLO
	zalem.puupuu.org") by vger.kernel.org with ESMTP id <S316213AbSFDEFi>;
	Tue, 4 Jun 2002 00:05:38 -0400
Date: Tue, 4 Jun 2002 00:05:38 -0400
From: Olivier Galibert <galibert@pobox.com>
To: "Hack inc." <linux-kernel@vger.kernel.org>
Subject: LOOP_CHANGE_FD patch?
Message-ID: <20020604000538.A1130@zalem.puupuu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	"Hack inc." <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there a version of the LOOP_CHANGE_FD ioctl patch around that works
on the latest 2.4.19pre kernels?  I tried to port it from the redhat
7.3 kernel, but /tmp/source fails its unmount yelling about busy
inodes...

  OG.
