Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261425AbUFNAbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbUFNAbv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 20:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261439AbUFNAbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 20:31:51 -0400
Received: from holomorphy.com ([207.189.100.168]:26269 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261425AbUFNAbu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 20:31:50 -0400
Date: Sun, 13 Jun 2004 17:31:48 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: [0/12] Debian bugfixes
Message-ID: <20040614003148.GO1444@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The following series of patches are strict bugfix patches taken from the
debian kernel. Among the various Debian patches, these were deemed
critical enough by me (e.g. not compilefixes or comment fixes) to merit
consideration for 2.6.7.

Each patch is accompanied with a hyperlink to the Debian BTS entry for
the bug it fixes and an except from the bugreport it addresses.

These patches were all written by others, in most of the cases, Herbert Xu.
hch did the work of splitting these out from Debian cvs.


-- wli
