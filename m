Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTIQTPL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 15:15:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262858AbTIQTPL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 15:15:11 -0400
Received: from piggy.rz.tu-ilmenau.de ([141.24.4.8]:3257 "EHLO
	piggy.rz.tu-ilmenau.de") by vger.kernel.org with ESMTP
	id S262610AbTIQTPH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 15:15:07 -0400
Date: Wed, 17 Sep 2003 19:11:11 +0200
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
To: linux-kernel@vger.kernel.org
Subject: 2.4.22: /proc/ide/ide?/hd?/capacity twice per directory
Message-ID: <20030917171111.GA23975@darkside.22.kls.lan>
Mail-Followup-To: Mario 'BitKoenig' Holbe <Mario.Holbe@RZ.TU-Ilmenau.DE>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Holla,

it seems, the capacity file in /proc/ide/ide?/hd? has
two directory entries.


regards,
   Mario
-- 
It is practically impossible to teach good programming style to students
that have had prior exposure to BASIC: as potential programmers they are
mentally mutilated beyond hope of regeneration.  -- Dijkstra
