Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269236AbTGOSHT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jul 2003 14:07:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269354AbTGOSHS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jul 2003 14:07:18 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:64999 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S269236AbTGOSGw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jul 2003 14:06:52 -0400
From: pavel@ucw.cz
To: "=?ISO-8859-1?Q?Jamie_Lokier?=" <jamie@shareable.org>,
       "=?ISO-8859-1?Q?K?= =?ISO-8859-1?Q?ent_Borg?=" <kentborg@borg.org>
Cc: "=?ISO-8859-1?Q?Pavel_Machek?=" <pavel@suse.cz>,
       "=?ISO-8859-1?Q?Dmitry_?= =?ISO-8859-1?Q?Torokhov?=" 
	<dtor_core@ameritech.net>,
       "=?ISO-8859-1?Q?Nige?= =?ISO-8859-1?Q?l_Cunningham?=" 
	<ncunningham@clear.net.nz>,
       "=?ISO-8859-1?Q??= =?ISO-8859-1?Q?swsusp-devel?=" 
	<swsusp-devel@lists.sourceforge.net>,
       "=?ISO-8859-1?Q??= =?ISO-8859-1?Q?linux-kernel?=" 
	<linux-kernel@vger.kernel.org>
Subject: =?ISO-8859-1?Q?RE:Re:_Thoughts_wanted_on_merging_Softwa?=
Date: 15 Jul 2003 20:20:55 +0000
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <20030715182117.BE2841675D3@smtp-out1.iol.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Both suspend-to-disk and suspend-to-ram are controlled by echo <num> > /proc/acpi/sleep.
If you are using apm, i have no idea how that works.
Anyway, depending on acpi is wrong and needs to be fixed in 2.7.
--p
