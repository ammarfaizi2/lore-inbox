Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315168AbSGYNtM>; Thu, 25 Jul 2002 09:49:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314938AbSGYNsN>; Thu, 25 Jul 2002 09:48:13 -0400
Received: from p3EE0262E.dip.t-dialin.net ([62.224.38.46]:7940 "EHLO
	srv.sistina.com") by vger.kernel.org with ESMTP id <S315168AbSGYNrg>;
	Thu, 25 Jul 2002 09:47:36 -0400
Date: Thu, 25 Jul 2002 15:39:44 +0200
From: "Heinz J . Mauelshagen" <mauelshagen@sistina.com>
To: linux-kernel@vger.kernel.org
Cc: mge@sistina.com
Subject: LVM 1.0.5 patch for Linux 2.4.19-rc3
Message-ID: <20020725153944.A8060@sistina.com>
Reply-To: mauelshagen@sistina.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


All,
have send an LVM 1.0.5 patch to Marcelo directly which addresses:

- an OBO error accessing the vg array
- SMP lock fixes
- using blk_ioctl()
- indenting


It is available at:
<http://people.sistina.com/~mauelshagen/lvm_patches/lvm_1.0.5+_25.07.2002.patch>


Regards,
Heinz    -- The LVM Guy --

=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

Heinz Mauelshagen                                 Sistina Software Inc.
Senior Consultant/Developer                       Am Sonnenhang 11
                                                  56242 Marienrachdorf
                                                  Germany
Mauelshagen@Sistina.com                           +49 2626 141200
                                                       FAX 924446
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
