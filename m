Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262812AbTBJUE2>; Mon, 10 Feb 2003 15:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262821AbTBJUE1>; Mon, 10 Feb 2003 15:04:27 -0500
Received: from port48.ds1-vbr.adsl.cybercity.dk ([212.242.58.113]:36652 "EHLO
	valis.localnet") by vger.kernel.org with ESMTP id <S262812AbTBJUE1>;
	Mon, 10 Feb 2003 15:04:27 -0500
Message-ID: <3E48080F.9060209@murphy.dk>
Date: Mon, 10 Feb 2003 21:14:07 +0100
From: Brian Murphy <brian@murphy.dk>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: mtdblock read only device broken?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is the mtd read only block device broken in general or is it only for 
mips that it
doesn't work?

Is it sheduled for removal / fixing or is it just forgotten because
everyone in the know uses the read / write driver which works.

The warning in the config option help for the read only driver seems to 
imply
that it is much more reliable to use it than the caching R/W driver, 
hence the
fact that I bothered looking at it at all, perhaps this recommendation 
should at
least be changed.

/Brian

