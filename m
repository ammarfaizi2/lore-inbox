Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132226AbRDPVdj>; Mon, 16 Apr 2001 17:33:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132281AbRDPVda>; Mon, 16 Apr 2001 17:33:30 -0400
Received: from cp912944-a.mtgmry1.md.home.com ([24.18.149.178]:22151 "EHLO
	zalem.puupuu.org") by vger.kernel.org with ESMTP id <S132226AbRDPVdQ>;
	Mon, 16 Apr 2001 17:33:16 -0400
Date: Mon, 16 Apr 2001 15:27:48 -0400
From: Olivier Galibert <galibert@pobox.com>
To: "Hack inc ." <linux-kernel@vger.kernel.org>
Subject: mount --bind and knfsd
Message-ID: <20010416152748.A2358@zalem.puupuu.org>
Mail-Followup-To: "Hack inc ." <linux-kernel@vger.rutgers.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mount --bind is a very nice tool to create multiple / directories for
diskless workstations.  Or, well, would be, if knfsd accepted to
export them.

I didn't try with 2.4.3 yet, only with an earlier version, does it
work there?  Or is it on womeone's todo?  Doesn't seem that
impossible, at least if you keep all the bindings on the same
filesystem and use nfsv3 with its larger handles.

  OG.

