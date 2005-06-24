Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbVFXMwv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbVFXMwv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 08:52:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262239AbVFXMwv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 08:52:51 -0400
Received: from trex.wsi.edu.pl ([195.117.114.133]:56549 "EHLO trex.wsi.edu.pl")
	by vger.kernel.org with ESMTP id S262330AbVFXMtt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 08:49:49 -0400
Message-ID: <42BBE593.9090407@trex.wsi.edu.pl>
Date: Fri, 24 Jun 2005 12:50:59 +0200
From: =?ISO-8859-2?Q?Micha=B3_Piotrowski?= <piotrowskim@trex.wsi.edu.pl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: pl, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Jesper Juhl <jesper.juhl@gmail.com>,
       Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
       randy_dunlap <rdunlap@xenotime.net>
Subject: [ANNOUNCE] ORT - Oops Reporting Tool
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Here is our (see copyright section ;)) simple script that help to create 
a bug report:
http://stud.wsi.edu.pl/~piotrowskim/files/ort/beta/ort-b1.tar.bz2
<http://stud.wsi.edu.pl/%7Epiotrowskim/files/ort/ort-a5.tar.bz2>

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

Regards,
Micha³ Piotrowski

