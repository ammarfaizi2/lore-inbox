Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318305AbSIPAZw>; Sun, 15 Sep 2002 20:25:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318310AbSIPAZw>; Sun, 15 Sep 2002 20:25:52 -0400
Received: from rwcrmhc51.attbi.com ([204.127.198.38]:39125 "EHLO
	rwcrmhc51.attbi.com") by vger.kernel.org with ESMTP
	id <S318305AbSIPAZw>; Sun, 15 Sep 2002 20:25:52 -0400
Date: Sun, 15 Sep 2002 20:30:38 -0400
From: Nicholas <TheUnforgiven@attbi.com>
To: linux-kernel@vger.kernel.org
Subject: To Anyone with a Radeon 7500 board and the ali developer
Message-Id: <20020915203038.240b901a.TheUnforgiven@attbi.com>
X-Mailer: Sylpheed version 0.8.2 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Dear Readers:
I would like to ask that anyone with this setup to please test this out
i think there is a kernel bug (if not Sorry for the email) when i run
glxgears (or any opengl) with my pc it locks hard when direct rendering
is enabled.  I have tried both GATOS drivers (http://gatos.sf.net) and
the defualt drivers that come with X both we the same results.  I think
there is a bug within either the Ali driver or the ATI Radeon 7500 drm
module (i have a few people say they have crashes not all the time but
sometimes) (i have tried this with out ali enabled with just agpgart and
it didn't do DRM) my system is an Asus mother board with ali agp and 256
megs of ram running Debian Sid with Xfree86 4.2
	Sincerly,
	Nicholas
