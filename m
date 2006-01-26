Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbWAZV6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbWAZV6b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 16:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964905AbWAZV6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 16:58:31 -0500
Received: from 1-1-12-13a.han.sth.bostream.se ([82.182.30.168]:2242 "EHLO
	palpatine.hardeman.nu") by vger.kernel.org with ESMTP
	id S1751434AbWAZV6a convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 16:58:30 -0500
Cc: dhowells@redhat.com, keyrings@linux-nfs.org, david@2gen.com
Subject: [PATCH 01/04] Add multi-precision-integer maths library
In-Reply-To: <1138312694656@2gen.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 26 Jan 2006 22:58:15 +0100
Message-Id: <1138312695665@2gen.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Reply-To: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
From: David =?iso-8859-1?Q?H=E4rdeman?= <david@2gen.com>
X-SA-Score: -0.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adds the multi-precision-integer maths library which was originally taken
from GnuPG and ported to the kernel by (among others) David Howells.
This version is taken from Fedora kernel 2.6.15-1.1871_FC5.

Signed-off-by: David Härdeman <david@2gen.com>

The patch is too large for LKML, so it's available at:
http://www.hardeman.nu/~david/lkml/01-add-mpilib


