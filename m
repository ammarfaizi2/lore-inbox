Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272767AbTHGEtq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 00:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275057AbTHGEtq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 00:49:46 -0400
Received: from mail11.speakeasy.net ([216.254.0.211]:23739 "EHLO
	mail.speakeasy.net") by vger.kernel.org with ESMTP id S272767AbTHGEtp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 00:49:45 -0400
Message-ID: <3F31DA6F.7000303@users.sourceforge.net>
Date: Wed, 06 Aug 2003 21:49:51 -0700
From: Cyril Bortolato <borto@users.sourceforge.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] gmodconfig 0.4 is released
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gmodconfig is a tool to manage Linux kernel modules. It features
a GNOME graphic interface which enables users to:
- configure kernel modules parameters in their native language
   and save settings to /etc/modules.conf
- access modules informations (author, license, link to website)
- check for new modules versions
- download, build and install modules packaged for DKMS

Some of this data is not found in modinfo's output and has to
be supplied to gmodconfig in XML files. A companion tool to
gmodconfig called gmodconfigedit can help module authors create
and update those XML files.

For details please visit:
http://gmodconfig.sourceforge.net/

This tool can help inexperienced Linux users to configure modules
(as is sometimes required with consumer devices like webcams)
without having to learn about /etc/modules.conf, and install or
upgrade modules with the click of a mouse, thanks to DKMS.
Experienced users might find it helpful, too.

It still has some rough edges and I welcome feedback from the
community. Please Cc me your comments as I'm not subscribed to
linux-kernel.

Thanks,
Cyril Bortolato

