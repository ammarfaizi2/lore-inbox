Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261612AbSJNM4M>; Mon, 14 Oct 2002 08:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261614AbSJNM4M>; Mon, 14 Oct 2002 08:56:12 -0400
Received: from pirun.ku.ac.th ([158.108.5.132]:39591 "EHLO pirun.ku.ac.th")
	by vger.kernel.org with ESMTP id <S261612AbSJNM4L>;
	Mon, 14 Oct 2002 08:56:11 -0400
Date: Mon, 14 Oct 2002 20:13:48 +0700 (ICT)
From: Theewara Vorakosit <g4465018@pirun.ku.ac.th>
To: linux-kernel@vger.kernel.org
Subject: NFS root on 2.4.18-14
Message-ID: <Pine.GSO.4.44.0210142012520.5993-100000@pirun.ku.ac.th>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All,
    I use Red Hat 8.0 and kernel 2.4.18-14, which come from redhat
distribution. I want create a NFS-root kernel to build a diskless linux
using NFS root. I select "IP kernel level configuration-> BOOTP, DHCP",
NFS root support. I boot client using my kernel, it does not requrest for
an IP address. It try to mount NFS root immediately. Do I forget
something?
Thanks,
Theewara


