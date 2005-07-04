Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVGDMpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVGDMpo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 08:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVGDMoU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 08:44:20 -0400
Received: from trex.wsi.edu.pl ([195.117.114.133]:6329 "EHLO trex.wsi.edu.pl")
	by vger.kernel.org with ESMTP id S261672AbVGDMn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 08:43:57 -0400
Message-ID: <42C92F22.80708@trex.wsi.edu.pl>
Date: Mon, 04 Jul 2005 14:44:18 +0200
From: =?ISO-8859-2?Q?Micha=B3_Piotrowski?= <piotrowskim@trex.wsi.edu.pl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       Paul TT <paultt@bilug.linux.it>, randy_dunlap <rdunlap@xenotime.net>,
       Vojtech Pavlik <vojtech@suse.cz>, Jesper Juhl <jesper.juhl@gmail.com>,
       cp@absolutedigital.net
Subject: [ANNOUNCE] OOPS Reporting Tool v.b5
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here is our (see copyright section ;)) simple script that help to create 
a bug report:
http://stud.wsi.edu.pl/~piotrowskim/files/ort/beta/ort-b5.tar.bz2

Why do we do this?
Because many people don't have time to prepare a good (with all 
importrant pieces of information) bug report.

How does it work?
It creates file with information about your system (software, hardware, 
used modules etc.), add file with oops into it and in the future sends 
it to the chosen mainterner or lkml.

How can you help?
If you know something about bash scripting you can review it, add some 
useful features and make some optimalisations. Or just send me an idea.

Changelog:
now you may do:
- short report (first 5 points)
- long report (old verbose style)
- custom report (you can choose what do you want to send)
- from template (ie. with USB informations)

- new logo (Maciej Soltysiak)

Todo:
- more e-mail clients
- more templates

Regards,
Micha³ Piotrowski
