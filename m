Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264928AbTL1CI2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 21:08:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264929AbTL1CIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 21:08:22 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:59841 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id S264928AbTL1CIC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 21:08:02 -0500
Date: Sat, 27 Dec 2003 21:07:59 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0 kernel panic
Message-ID: <20031228020759.GA2158@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

P4 2GHz
ASUS P4S533 mainboard
1G PC2700 RAM
GF2 GTS video using nv driver
2.6.0 compiled with gcc 3.3.2

At boot kernel gets:
   INIT: cannot execute "/etc/rc.d/rc.sysinit"
then panic.

Same configuration for 2.6.0-test11 and earlier works fine.

-- 
Murray J. Root

