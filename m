Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262976AbRE1Ffc>; Mon, 28 May 2001 01:35:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262977AbRE1FfW>; Mon, 28 May 2001 01:35:22 -0400
Received: from asplinux.ru ([195.133.213.194]:9744 "EHLO relay.asplinux.ru")
	by vger.kernel.org with ESMTP id <S262976AbRE1FfS>;
	Mon, 28 May 2001 01:35:18 -0400
Message-ID: <3B11E3F1.1090400@acronis.com>
Date: Mon, 28 May 2001 09:36:49 +0400
From: Yuri Per <yuri@acronis.com>
Organization: Acronis
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:0.9) Gecko/20010505
X-Accept-Language: ru, en
MIME-Version: 1.0
To: Martin von Loewis <loewis@informatik.hu-berlin.de>,
        Anton Altaparmakov <aia21@cam.ac.uk>
CC: linux-kernel@vger.kernel.org, Linux-ntfs@tiger.informatik.hu-berlin.de,
        linux-ntfs-dev@lists.sourceforge.net
Subject: Re: [Linux-ntfs] Re: [Linux-NTFS-Dev] Re: ANN: NTFS new  release available (1.1.15)
In-Reply-To: <5.1.0.14.2.20010526011903.00aab050@pop.cus.cam.ac.uk> <5.1.0.14.2.20010526000503.04716ec0@pop.cus.cam.ac.uk> <5.1.0.14.2.20010526011903.00aab050@pop.cus.cam.ac.uk> <5.1.0.14.2.20010527123154.00a96640@pop.cus.cam.ac.uk> <200105271253.OAA22557@pandora.informatik.hu-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin von Loewis wrote:

>That would not work: NT would split individual runs across extends
>(i.e. split them in the middle). Did I misunderstand, or do you have a
>solution for that as well.
>
Are you sure that it's true? My NTFS resizer interprets parts of runlist 
stored in different FILE records independently and I never experienced 
any problems with that.


Yuri


