Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129740AbRCCUdV>; Sat, 3 Mar 2001 15:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129741AbRCCUdK>; Sat, 3 Mar 2001 15:33:10 -0500
Received: from 513.holly-springs.nc.us ([216.27.31.173]:55773 "EHLO
	513.holly-springs.nc.us") by vger.kernel.org with ESMTP
	id <S129740AbRCCUc7>; Sat, 3 Mar 2001 15:32:59 -0500
Message-Id: <200103032123.f23LNeQ22940@513.holly-springs.nc.us>
Subject: physmem w/o proc
From: Michael Rothwell <rothwell@holly-springs.nc.us>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
X-Mailer: Evolution (0.8/+cvs.2001.02.14.08.55 - Preview Release)
Date: 03 Mar 2001 16:34:07 -0500
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

physmem= `head -10 /var/log/dmesg | grep Memory: | cut -d" " -f2 | cut
-d "/" -f1 | cut -d"k" -f1`

