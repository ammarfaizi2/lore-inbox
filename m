Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262235AbTICOFa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 10:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbTICOFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 10:05:30 -0400
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:13581 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id S262235AbTICOF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 10:05:26 -0400
Date: Wed, 3 Sep 2003 09:05:21 -0500
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Subject: svn updating of linux-2.4 kernel failing
Message-ID: <20030903140521.GC12483@artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I'd downloaded the 2.4 kernel with svn and built it yesterday. Now I'm
trying to update it and I'm getting this ...

$ svn update
svn: No such file or directory
svn: svn_io_copy_file: error copying
'arch/ia64/scripts/.svn/text-base/check-gas-for-hint.S.svn-base' to
'arch/ia64/scripts/.svn/tmp/text-base/check-gas-for-hint.S.svn-base.tmp'
$

Is anyone else seeing this?

Art Haas
-- 
Man once surrendering his reason, has no remaining guard against absurdities
the most monstrous, and like a ship without rudder, is the sport of every wind.

-Thomas Jefferson to James Smith, 1822
