Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264451AbTEPVJj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 May 2003 17:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264533AbTEPVJj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 May 2003 17:09:39 -0400
Received: from mail.gmx.net ([213.165.65.60]:13562 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264451AbTEPVJi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 May 2003 17:09:38 -0400
Message-ID: <3EC55688.6060605@gmx.net>
Date: Fri, 16 May 2003 23:22:16 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Tomas Szepe <szepe@pinerecords.com>
CC: esp@pyroshells.com, linux-kernel@vger.kernel.org
Subject: Re: FAT32 problems with kernel 2.4.19
References: <23493.65.122.196.250.1053063209.squirrel@mail.webhaste.com> <20030516194628.GS3478@louise.pinerecords.com>
In-Reply-To: <20030516194628.GS3478@louise.pinerecords.com>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomas Szepe wrote:
> [esp@pyroshells.com]
> 
>> When I'm writing to FAT32 partition, there seems to be a 300% incurred
>> size penalty over the equivalent files on ext2 (when unpacking a
>> source distribution like boost, gcc, etc)
> 
> I don't understand what you're trying to say.  Can you elaborate?

If I understand him correctly, he is happy that ext2 has not as much
overhead as FAT32.

esp@pyroshells.com: If you think the FAT32 overhead is a linux problem,
please unpack the same source tree under windows on the same partition
and report back if the space used is less than when unpacking this
source tree under linux.


HTH,
Carl-Daniel
-- 
http://www.hailfinger.org/

