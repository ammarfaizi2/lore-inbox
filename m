Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261384AbTKDMaH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 07:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTKDMaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 07:30:07 -0500
Received: from ns.schottelius.org ([213.146.113.242]:7840 "HELO
	ns.schottelius.org") by vger.kernel.org with SMTP id S261384AbTKDMaF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 07:30:05 -0500
Date: Tue, 4 Nov 2003 13:30:12 +0100
From: Nico Schottelius <nico-linux-kernel@schottelius.org>
To: linux-kernel@vger.kernel.org, andrew.grover@intel.com
Cc: paul.s.diefenbaugh@intel.com
Subject: ACPI: no battery information
Message-ID: <20031104123012.GC8062@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Linux-Info: http://linux.schottelius.org/
X-Operating-System: Linux bruehe 2.6.0-test4
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I am using 2.6.0test9 and I have an empty /proc/acpi/battery dir:

scice:/usr/src/linux# ls /proc/acpi/battery/
scice:/usr/src/linux#

What can I do to debug this and to read the battery states?
My computer does not have an apm bios anymore, so I can't access it
this way.
It's the egs elitebook a530.

Any ideas? Any more information you need?

Nico
