Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261391AbTCJSCf>; Mon, 10 Mar 2003 13:02:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261392AbTCJSCe>; Mon, 10 Mar 2003 13:02:34 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:47631 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S261391AbTCJSCd>; Mon, 10 Mar 2003 13:02:33 -0500
Date: Mon, 10 Mar 2003 13:12:51 -0500
From: Ben Collins <bcollins@debian.org>
To: Greg KH <greg@kroah.com>
Cc: Patrick Mochel <mochel@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Device removal callback
Message-ID: <20030310181251.GA1311@phunnypharm.org>
References: <20030310010232.GB16134@phunnypharm.org> <Pine.LNX.4.33.0303100949490.1002-100000@localhost.localdomain> <20030310165548.GA753@phunnypharm.org> <20030310172155.GA9792@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030310172155.GA9792@kroah.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's less work to add all this overhead back into my subsystem than to
argue about it's worthiness. It seemed obviously in-line with the
driver-model's purpose to have a remove callback, but maybe my way of
thinking is expecting too much from the driver core, and I should do the
work myself in the subsystem.

thanks

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
