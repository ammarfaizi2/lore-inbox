Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271740AbTGRM3T (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 08:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271743AbTGRM3S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 08:29:18 -0400
Received: from tomts24-srv.bellnexxia.net ([209.226.175.187]:31207 "EHLO
	tomts24-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S271740AbTGRM3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 08:29:15 -0400
Date: Fri, 18 Jul 2003 08:42:59 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: confusing ACPI, APM menu dependencies
Message-ID: <Pine.LNX.4.53.0307180839400.4641@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  in "make xconfig" for 2.6.0-test1-ac2, the menu entries for
power management are a little confusing.

  the top-level entry for "Power management options (ACPI, APM)"
seems to suggest that you have to at least select this top-level
entry before you can be more specific.

  yet, even without selecting this, you can still select ACPI.
this is definitely a bit confusing given the label and help
screens for these menu entries.

  can someone clarify this?  or perhaps reword the menu entries
to make it more obvious what the choices and dependencies are.

rday
